package com.bookingservice.controller;

import com.bookingservice.event.BookingStatus;
import com.bookingservice.model.BookingDetail;
import com.bookingservice.model.OTPRequest;
import com.bookingservice.model.PaymentRequest;
import com.bookingservice.repository.BookingRepository;
import com.bookingservice.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;

import java.net.MalformedURLException;
import java.net.URI;
import java.util.List;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/booking")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private RestTemplate restTemplate;

    WebClient webClient = WebClient.builder()
            .baseUrl("http://localhost:8089/payment")
            .build();

    @PostMapping("/")
    public ResponseEntity<BookingDetail> createBooking(@RequestBody BookingDetail booking) {

        /*if (bookingService.isSeatAvailable(booking.getSeatNo())) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }*/
        booking.setBookingStatus("INCOMPLETE");
        this.bookingService.createBooking(booking);
        return ResponseEntity.ok(booking);
    }

    @PostMapping("/payment")
    public ResponseEntity<?> createPayment(@RequestBody PaymentRequest paymentReq){
        if (bookingService.isBookingInProgress(paymentReq.getBookingId())){
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            ResponseEntity<?> res = restTemplate.postForEntity("http://localhost:8089/payment/initiate", new HttpEntity<>(paymentReq,headers), String.class);
            return res;
            /*Mono<ResponseEntity<PaymentRequest>> responseMono = webClient.post()
                    .uri("/initiate")
                    .bodyValue(paymentReq)
                    .retrieve()
                    .toEntity(PaymentRequest.class);

            ResponseEntity<PaymentRequest> result = responseMono.block();

            if (result.getStatusCode().is2xxSuccessful()) {
                PaymentRequest paymentResponse = result.getBody();
                // process payment response
                return ResponseEntity.ok(paymentResponse);
            } else {
                // handle error response
                return ResponseEntity.ok("Payment unsuccessful");
            }*/

        }else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

    }

    @PostMapping("/verify")
    public ResponseEntity<?> verifyOtp(@RequestBody OTPRequest otpRequest, @RequestParam(value = "cardNumber") String cardNumber,@RequestParam(value = "price")Double price,@RequestParam(value = "bookingId")Long bookingId) throws MalformedURLException {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        ResponseEntity<?> res = restTemplate.postForEntity("http://localhost:8089/payment/verify?cardNumber="+cardNumber+"&price="+price, new HttpEntity<>(otpRequest,headers), String.class);

        Optional<BookingDetail> optionalUser = Optional.ofNullable(bookingRepository.findByBookingId(bookingId));

        if (optionalUser.isPresent()) {
            BookingDetail user = optionalUser.get();
            user.setBookingStatus("COMPLETED");

            this.bookingRepository.save(user);
        }

        return res;
    }

    @GetMapping("/ByBookingId")
    public BookingDetail getBookingDetail(@RequestParam(value = "bookingId") Long bookingId) {
        return this.bookingService.getBookingDetail(bookingId);
    }

    @GetMapping("/byUsername")
    public List<BookingDetail> getAllBooking(@RequestParam(value = "username") String username) {
        return this.bookingService.getAllBooking(username);
    }

}
