package com.bookingservice.model;


public class PaymentRequest {


    private Long paymentId;

    private Long bookingId;
    private String email;
    private CreditCardDetails creditCardDetails;

    private Double amount;

    // Constructors, getters and setters


    public PaymentRequest() {
    }

    public PaymentRequest(Long paymentId, Long bookingId, String email, CreditCardDetails creditCardDetails, Double amount) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.email = email;
        this.creditCardDetails = creditCardDetails;
        this.amount = amount;
    }

    public Long getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public CreditCardDetails getCreditCardDetails() {
        return creditCardDetails;
    }

    public void setCreditCardDetails(CreditCardDetails creditCardDetails) {
        this.creditCardDetails = creditCardDetails;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }
}

