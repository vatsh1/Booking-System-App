package com.hotelservice.hotelservice.repo;

import com.hotelservice.hotelservice.models.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Long> {

    List<Hotel> findByCity(String city);
    List<Hotel> findByCityIgnoreCase(String city);

}
