///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.gast.fabric.smartcontractTest;
//
//import com.gast.fabric.smartcontract.TransactionContrat;
//import com.gast.fabric.smartcontract.gastTransaction;
//import org.hyperledger.fabric.contract.Context;
//import org.hyperledger.fabric.shim.ChaincodeStub;
//import org.junit.jupiter.api.Nested;
//import org.junit.jupiter.api.Test;
//
//import static org.assertj.core.api.Assertions.assertThat;
//import static org.mockito.Mockito.mock;
//import static org.mockito.Mockito.when;
//
///**
// *
// * @author vaka
// */
//public final class transactionTest {
//    
//    @Nested
//    class InvokeQueryAgreementTransaction {
//
//        @Test
//        public void whenAgreementExists() {
//            TransactionContrat contract = new TransactionContrat();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//            when(stub.getStringState("toto"))
//                    .thenReturn("{\"transactionID\":\"25\",\"cardID\":\"hello\","
//                            + "\"amount\":\"amount\",\"nature\":\"FRAUD\""
//            + "\"type\":\"CASHIN\"}");
//            
//            gastTransaction transact = contract.getTransationByUser(ctx, "toto");
//
//            assertThat(transact.getTranctionID())
//                    .isEqualTo("25");
//            assertThat(transact.getCardID())
//                    .isEqualTo("hello");
//            assertThat(transact.getAmount())
//                    .isEqualTo("4200");
//            assertThat(transact.getNature())
//                    .isEqualTo("FRAUD");
//            assertThat(transact.getType())
//                    .isEqualTo("CASHIN");
//        }
//
////        @Test
////        public void whenCarDoesNotExist() {
////            AgreementRepository contract = new AgreementRepository();
////            Context ctx = mock(Context.class);
////            ChaincodeStub stub = mock(ChaincodeStub.class);
////            when(ctx.getStub()).thenReturn(stub);
////            when(stub.getStringState("ARG000")).thenReturn("");
////
////            Throwable thrown = catchThrowable(() -> {
////                contract.getAgreement(ctx, "ARG000");
////            });
////
////            assertThat(thrown).isInstanceOf(ChaincodeException.class).hasNoCause()
////                    .hasMessage("Agreement ARG000 does not exist");
////        }
////
////    }
////
//}
//    
//}
