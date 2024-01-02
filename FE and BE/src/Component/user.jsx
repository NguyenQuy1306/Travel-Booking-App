import React, { useEffect } from "react";  
import { useNavigate } from "react-router-dom";
import SearchingPlane from "./searchingPlane";
import SearchingHotel from "./searchingHotel";
import SearchingRestaurant from "./searchingRestaurant";
import { useState } from "react";
import Cookie from "universal-cookie";
import axios from "axios";

const cookie = new Cookie();

export default function User() {
    const [isEmpty, setIsEmpty] = useState(true);
    const navigate = useNavigate();
    const handleScroll = () =>{
      window.scroll({
        top: 500, 
        behavior: 'smooth'
      });
    }
    useEffect(() => {
      // check if localStorage is empty 
      if (localStorage.getItem("ticket") === null) {
        setIsEmpty(true);
      }
      else setIsEmpty(false);
    }, []);
    const handleLogout = () =>{
      cookie.remove("token");
      cookie.remove("role");
      localStorage.clear();
      navigate('/');
    }
    const handleOrder = async () => {
      try {
        const orderResponse = await axios.post("http://localhost:5000/order/generate", { token: cookie.get("token") });
        const orderId = orderResponse.data.orderId;
        const ticket = JSON.parse(localStorage.getItem("ticket"));
    
        for (let i = 0; i < ticket.length; i++) {
          const passenger = ticket[i].passenger;
    
          try {
            const flightTicketResponse = await axios.post("http://localhost:5000/flightTicket/generate", { token: cookie.get("token"),flightID: ticket[i].flightID, orderId });
            const ticketId = flightTicketResponse.data['ticketId'];
    
            const insertPassenger = async (data) => {
              try {
                const passengerResponse = await axios.post("http://localhost:5000/passenger/insert", data);
                console.log(passengerResponse);
                console.log("Passenger generated");
              } catch (err) {
                console.error(err);
                console.log("Passenger not generated");
              }
            };
    
            for (let j = 0; j < passenger.length; j++) {
              try {
                const data = {
                  token: cookie.get("token"),
                  name: passenger[j].name,
                  phonenumber: passenger[j].phonenumber,
                  email: passenger[j].email,
                  CCCD: passenger[j].CCCD,
                  birthday: passenger[j].birthday,
                  ticketId: ticketId,
                  flightId: passenger[j].flightID,
                  cabinType: passenger[j].cabinType,
                };
    
                await insertPassenger(data);
              } catch (err) {
                console.error(err);
              }
            }
          } catch (err) {
            console.error(err);
            console.log("Ticket not generated");
          }
        }
    
        console.log("All tickets generated");
        localStorage.clear();
        setIsEmpty(true);
      } catch (err) {
        console.error(err);
      }
    };
    
    

   return (
      <>
      <section className="relative isolate overflow-hidden bg-gray-900 xl:h-full pb-10">
        <img
          src="/hero-banner.jpg"
          alt=""
          // make backgorund grey color to transparent
          className="absolute inset-0 -z-10 h-full w-full object-cover object-right md:object-center opacity-30"
        />
        <nav className="p-12  ">
          <hr/>
          <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto py-5">
            <hr/>
            <div class="hidden w-full md:block md:w-auto" id="navbar-default">
              <ul class="font-medium flex flex-col mt-4 border md:flex-row md:space-x-8 rtl:space-x-reverse md:mt-0 md:border-0 text-lg">
                <li>
                  <button  className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">
                    <img src="bell.svg" className="h-8" />
                  </button>
                </li>
                <li>
                  <button 
                  onClick={() => navigate('/cart')}
                  className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">
                    <img src="cart-shopping.svg" className="h-8" />
                  </button>
                </li>
                <li>
                  <a href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Your promotion</a>
                </li>
                <li>
                  <button onClick={() => navigate('/account')} href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Account</button>
                </li>
                <li>
                  <button onClick={handleLogout}  className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Logout</button>
                </li>
                
              </ul>
            </div>
          </div>
          <hr/>
        </nav>
        <div className="mx-auto px-auto pb-7">
          <div className="grid">
            <h2 className="text-4xl font-bold tracking-wider text-white sm:text-7xl place-content-center text-center font-serif ">READY FOR THE NEXT TRIP ?</h2>
            <p className="mt-6 text-xl leading-8 text-gray-300 text-center"> 
           "<span className="text-2xl font-bold font-serif text-teal-400">Pack</span> your dreams, <span className="text-2xl font-bold font-serif text-teal-400">lace</span> up your wanderlust, and <span className="text-2xl font-bold font-serif text-teal-400">buckle</span> in for a journey of a lifetime" <br/>
           <span className="font-serif">'READY for the Next Trip'</span> - Because every adventure begins with anticipation. <br/>
            <span className="text-2xl font-bold text-amber-300">Where to next?</span> 
            </p>
          </div>
        </div>
        <div className="text-white text-center">
          <button 
            onClick={
              (isEmpty) ? handleScroll : handleOrder
            }
          className="bg-gray-400 p-3 rounded-3xl font-serif font-medium text-4xl hover:bg-teal-300 hover:text-fuchsia-500">Order now</button>
        </div>
      </section>
      <section className="pb-10 pt-5">
        <SearchingPlane/>
        <SearchingHotel/>
        <SearchingRestaurant/>
      </section>
      </>
    );
}