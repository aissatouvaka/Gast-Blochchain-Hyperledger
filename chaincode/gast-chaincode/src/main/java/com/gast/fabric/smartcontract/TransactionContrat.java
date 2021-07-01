package com.gast.fabric.smartcontract;

import com.owlike.genson.Genson;
import java.util.ArrayList;
import java.util.List;
import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.Transaction;
import org.hyperledger.fabric.contract.routing.TransactionType;
import org.hyperledger.fabric.shim.ChaincodeException;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.hyperledger.fabric.shim.ledger.KeyValue;
import org.hyperledger.fabric.shim.ledger.QueryResultsIterator;

@Contract(
        name = "GastTransaction",
        info = @Info(
                title = "Transaction Transfer",
                description = "The hyperledger chaincode java",
                version = "0.0.1-SNAPSHOT"))
@Default
public final class TransactionContrat implements ContractInterface {

    private final Genson genson = new Genson();

    private enum TransactionTransferErrors {
        TRANSACTION_NOT_FOUND
    }

    /**
     * Creates some initial transaction on the ledger.
     *
     * @param ctx the transaction context
     */
    
    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public void InitLedger(final Context ctx) {
        ChaincodeStub stub = ctx.getStub();
        
//        gastTransaction transct = new gastTransaction("25", "hello", Double.valueOf(4200), Nature.FRAUD, Type.CASHIN);
//
//        String transactState = genson.serialize(transct);
//        stub.putStringState("toto", transactState);


    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public gastTransaction saveTransaction(final Context ctx, final String tranctionID, final String cardID,
            final Double amount, final Nature nature, final Type type) {
        ChaincodeStub stub = ctx.getStub();
        gastTransaction transact = new gastTransaction(tranctionID, cardID, amount, nature, type);
        String transactJSON = genson.serialize(transact);
        stub.putStringState(tranctionID, transactJSON);

        return transact;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String getAllTransaction(final Context ctx) {
        ChaincodeStub stub = ctx.getStub();

        List<gastTransaction> queryResults = new ArrayList<gastTransaction>();

        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

        for (KeyValue result : results) {
            gastTransaction transact = genson.deserialize(result.getStringValue(), gastTransaction.class);
            queryResults.add(transact);
            System.out.println(transact.toString());
        }

        final String response = genson.serialize(queryResults);

        return response;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public gastTransaction getTransationByUser(final Context ctx, final String transactionID) {
        ChaincodeStub stub = ctx.getStub();
        String transactJSON = stub.getStringState(transactionID);

        if (transactJSON == null || transactJSON.isEmpty()) {
            String errorMessage = String.format("Transaction %s does not exist", transactionID);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, TransactionTransferErrors.TRANSACTION_NOT_FOUND.toString());
        }

        gastTransaction transact = genson.deserialize(transactJSON, gastTransaction.class);
        return transact;
    }

}
