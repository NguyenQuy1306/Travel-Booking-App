import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import PassengerList from "../Utils/PopupPassenger";
import Cookies from "universal-cookie";

export default function TicketPlane() {
    const cookie = new Cookies();
    const [showPassenger, setShowPassenger] = useState(false);
    const handleOnClose = () => {
        setShowPassenger(false);
    }
    // const quantityOfTicket = (localStorage.getItem("ticket") === null)?0:JSON.parse(localStorage.getItem("ticket")).length;
    const [quantityOfTicket, setQuantityOfTicket] = useState(0);
    // const ticket = JSON.parse(localStorage.getItem("ticket"));
    const [ticket, setTicket] = useState([]);
    const [totalCost, setTotalCost] = useState(0);
    useEffect(() => {
      setQuantityOfTicket((localStorage.getItem("ticket") === null)?0:JSON.parse(localStorage.getItem("ticket")).length);
      setTicket(JSON.parse(localStorage.getItem("ticket")));
      let temp = 0
      for (let i = 0; i < quantityOfTicket; i++) {
        temp += ticket[i].total;
      }   
      setTotalCost(temp);
  } , [ticket])
    useEffect(() => {
        console.log(ticket);
    } , [])

    const navigate = useNavigate();
    const handleLogout = () =>{
      cookie.remove("token");
      cookie.remove("role");
      localStorage.clear();
      navigate('/');
    }
    const getTicket = () => {
        let content = [];
        for (let i = 0; i < quantityOfTicket; i++) {
          content.push(
          <div className="border border-gray-300 p-6 grid grid-cols-3 gap-3 bg-white shadow-lg rounded-lg">
            <div className="font-bold text-teal-600">Ticket {i} </div> 
            <div className="font-semibold">The number of passengers: <span className="text-teal-600 font-semibold">{JSON.parse(localStorage.getItem("ticket"))[i].passenger.length}</span></div>
            <div className="text-end"><button
              onClick={() => {
                if (window.confirm("Are you sure you wish to delete this item?")){
                  console.log(ticket[i]) 
                  let temp = JSON.parse(localStorage.getItem("ticket"));
                  temp.splice(i, 1);
                  localStorage.setItem("ticket", JSON.stringify(temp));
                  if (temp.length === 0) {
                    localStorage.removeItem("ticket");
                  }
                }   
              }
              }
            ><img src="/close.svg" className="h-7"/></button></div>
            <div className="font-bold">Flight ID: <span className="text-teal-400">{ticket[i].flightID} </span></div>
            <div className="font-semibold ">Departure: <br/><span className="text-teal-400">{ticket[i].departure}</span></div>
            <div className="font-semibold ">Arrival: <br/><span className="text-teal-400">{ticket[i].arrival}</span></div>
            <button onClick={
              ()=>{
                localStorage.setItem("Ticket ID", i);
                setShowPassenger(true)
              }
            }><img src="/ticket.svg" className="h-10" /></button>
            <div className="font-semibold"><span className="text-teal-400">{ticket[i].timeDeparture}</span></div>
            <div className="font-semibold"><span className="text-teal-400">{ticket[i].timeArrival}</span></div>
            <div></div>
            <div className="font-bold">Total cost: <span className="font-medium text-green-500">{new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(ticket[i].total)}</span></div>
          </div>
          )
        }
    return content
    }
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
                    <img src="/bell.svg" className="h-8" />
                  </button>
                </li>
                <li>
                    <button 
                    onClick={() => navigate('/user')}
                    className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">
                        <img src="/arrow-left.svg" className="h-8" />
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
        <div className="mx-auto px-auto pb-5">
          <div className="grid">
            <h2 className="text-xl font-bold tracking-wider text-white sm:text-xl place-content-center text-center font-serif "> "Guard that ticket like a treasure, for within it lies the key to unforgettable moments and lifelong memories"</h2>
            <h2 className="text-2xl font-bold tracking-wider text-white sm:text-2xl place-content-center text-center font-serif pt-7"> Let the journey begin!</h2>
          </div>
        </div>
      </section>
      <section>
        <div className="text-center font-bold font-serif pt-7 pb-3 text-3xl">
          {
            (quantityOfTicket === 0)? <span>You have no ticket Yet :( </span> : <div>Your plane tickets are <span className="text-green-500">READY</span></div>
          }
        </div>
        <div className="text-center font-medium font-serif text-lg pb-3"> Number of tickets: {quantityOfTicket}</div>
        <div className="text-center font-medium font-serif text-xl"> Total: <span className="text-green-500">{new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(totalCost)}</span></div>
        <div className="container my-7 mx-auto grid grid-cols-2 gap-20 justify-center items-center p-2 md:p-0">          
            {getTicket()}
        </div>
        <PassengerList visible={showPassenger} onClose={handleOnClose}/>
      </section>
    </>
    )
}