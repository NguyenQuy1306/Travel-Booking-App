import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";

// the most popular city in vietnam
const hotelCity = [
  "Ho Chi Minh",
  "Hanoi",
  "Da Nang"
]

export default function SearchingHotel() {
    const [city, setCity] = useState("")
    const [checkIn, setCheckIn] = useState("")
    const [checkOut, setCheckOut] = useState("")
    const navigate = useNavigate();
    useEffect(() => {
      if (localStorage.getItem('currentHotel') !== null) {
          const data = JSON.parse(localStorage.getItem('currentHotel')).hotels[0];
          if(data != null){
            setCity(data.city)
            setCheckIn(data.checkInDate)
            setCheckOut(data.checkOutDate)
          }
      }
      else {
        setCity("")
        setCheckIn("")
        setCheckOut("")
      }
    }, [localStorage.getItem('currentHotel')]);
    const handleFindHotel = () => {
      if (city === "" || checkIn === "" || checkOut === "") {
        alert("Please fill all the information");
        return ;
      }
      // check checkOut and checkInDate
      const data = {  
        checkInDate: checkIn,
        checkOutDate: checkOut,
        city: city,
      }
      localStorage.setItem("currentHotel", JSON.stringify({hotels : [data]}));
      navigate("/user/ListHotel");
    }
   
    return (
        <div >
        <div className="flex justify-center pt-3 text-3xl font-medium font-serif">Finding your rest place</div>
        <div className="container my-7 mx-auto flex justify-center items-center p-2 md:p-0">
          <div className="border border-gray-300 p-6 grid grid-cols-1 gap-6 bg-white shadow-lg rounded-lg">
            <div className="flex flex-col md:flex-row justify-between">
              <div className="w-full justify-start flex"></div>
              <div className="w-full justify-center flex">
                <img src="hotel.svg" className="h-10" />
              </div>
              <div className="w-full justify-end flex">
                <img src="ticket.svg" className="h-10" />
              </div>
              
            </div>
            <div className="grid grid-cols-1 gap-4">
              <div className="grid grid-cols-3 gap-2 border border-gray-200 p-2 rounded">
                <div className="flex border rounded bg-gray-100 items-center p-2 ">
                    <img src="city.svg" className="px-2"/>
                    {/* the arrow of select is left side */}
                    <select dir="rtl"
                    onChange={
                      (e)=>{
                        setCity(e.target.value);
                      }
                    }
                    className="bg-gray-100 max-w-full focus:outline-none text-gray-700">
                      <option value={city} disabled selected>{(city === "")?"city":city} </option>
                      {
                        hotelCity.map((item)=>{
                          return <option value={item}>{item}</option>
                        })
                      }
                    </select>
                </div>
                <div className="flex border rounded bg-gray-100 items-center p-2 ">
                  Check-in
                  <svg className="fill-current text-gray-800 ml-5 mr-2 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                    <path className="heroicon-ui" d="M14 5.62l-4 2v10.76l4-2V5.62zm2 0v10.76l4 2V7.62l-4-2zm-8 2l-4-2v10.76l4 2V7.62zm7 10.5L9.45 20.9a1 1 0 0 1-.9 0l-6-3A1 1 0 0 1 2 17V4a1 1 0 0 1 1.45-.9L9 5.89l5.55-2.77a1 1 0 0 1 .9 0l6 3A1 1 0 0 1 22 7v13a1 1 0 0 1-1.45.89L15 18.12z" />
                  </svg>
                  <input type="date" 
                  className="bg-gray-100 max-w-full focus:outline-none text-gray-700 w-32"  
                  value ={checkIn}
                  onFocus={(e) => (e.currentTarget.type = "date")}
                  onBlur={(e) => (e.currentTarget.type = "text")}
                  onChange={
                    (e)=>{
                      setCheckIn(e.target.value);
                      console.log(checkIn)
                    }
                  }
                  />
                </div>
                <div className="flex border rounded bg-gray-100 items-center p-2 ">
                  Check-out
                  <svg className="fill-current text-gray-800 ml-5 mr-2 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                    <path className="heroicon-ui" d="M14 5.62l-4 2v10.76l4-2V5.62zm2 0v10.76l4 2V7.62l-4-2zm-8 2l-4-2v10.76l4 2V7.62zm7 10.5L9.45 20.9a1 1 0 0 1-.9 0l-6-3A1 1 0 0 1 2 17V4a1 1 0 0 1 1.45-.9L9 5.89l5.55-2.77a1 1 0 0 1 .9 0l6 3A1 1 0 0 1 22 7v13a1 1 0 0 1-1.45.89L15 18.12z" />
                  </svg>
                  <input type="date"  
                  className="bg-gray-100 max-w-full focus:outline-none text-gray-700 w-32" 
                  value={checkOut}
                  onFocus={(e) => (e.currentTarget.type = "date")}
                  onBlur={(e) => (e.currentTarget.type = "text")}
                  onChange={
                    (e)=>{
                      if (e.target.value < checkIn) {
                        alert("Check-out date must be after check-in date");
                        return ;
                      }
                      setCheckOut(e.target.value);
                    }
                  }
                  
                  />
                </div>
              </div>
            </div>
            <div className="flex justify-center"><button className="p-2 border w-1/4 rounded-md bg-gray-800 text-white" onClick={handleFindHotel}
            >Search</button></div>
          </div>
        </div>
      </div>
    )
}