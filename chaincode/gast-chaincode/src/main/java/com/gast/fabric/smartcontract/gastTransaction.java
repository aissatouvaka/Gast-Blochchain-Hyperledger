package com.gast.fabric.smartcontract;

import com.owlike.genson.annotation.JsonProperty;

import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

@DataType
public final class gastTransaction {
    
    @Property
    private String tranctionID;

    @Property
    private String cardID;

    @Property
    private Double amount;

    @Property
    private Nature nature;

    @Property
    private Type type;


    public gastTransaction(
        @JsonProperty("tranctionID") final String tranctionID, 
        @JsonProperty("cardID") final String cardID, 
        @JsonProperty("amount") final Double amount, 
        @JsonProperty("nature") final Nature nature, 
        @JsonProperty("type") final Type type) {
        this.tranctionID = tranctionID;
        this.cardID = cardID;
        this.amount = amount;
        this.nature = nature;
        this.type = type;
    }
    
    

    public String getTranctionID() {
        return tranctionID;
    }

    public void setTranctionID(String tranctionID) {
        this.tranctionID = tranctionID;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Nature getNature() {
        return nature;
    }

    public void setNature(Nature nature) {
        this.nature = nature;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public void setCardID(String cardID) {
        this.cardID = cardID;
    }

    public String getCardID() {
        return cardID;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((amount == null) ? 0 : amount.hashCode());
        result = prime * result + ((cardID == null) ? 0 : cardID.hashCode());
        result = prime * result + ((nature == null) ? 0 : nature.hashCode());
        result = prime * result + ((tranctionID == null) ? 0 : tranctionID.hashCode());
        result = prime * result + ((type == null) ? 0 : type.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        gastTransaction other = (gastTransaction) obj;
        if (amount == null) {
            if (other.amount != null)
                return false;
        } else if (!amount.equals(other.amount))
            return false;
        if (cardID == null) {
            if (other.cardID != null)
                return false;
        } else if (!cardID.equals(other.cardID))
            return false;
        if (nature != other.nature)
            return false;
        if (tranctionID == null) {
            if (other.tranctionID != null)
                return false;
        } else if (!tranctionID.equals(other.tranctionID))
            return false;
        if (type != other.type)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "Transaction [amount=" + amount + ", cardID=" + cardID + ", nature=" + 
        nature + ", tranctionID=" + tranctionID + ", type=" + type + "]";
    }

}
