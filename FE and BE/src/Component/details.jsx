import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import PassengerListOrder from "../Utils/PopupPassengerOrder";
import Cookies from "universal-cookie";
import axios from "axios";
export default function Details() {
    const cookie = new Cookies();
    const [ticket, setTicket] = useState([]);
    const [go,setGo] = useState(false);
    useEffect(() => {
      (async () => {
        axios.post("http://localhost:5000/getTicketOfOrder", { token: cookie.get("token"), MaDonHang: localStorage.getItem("MaDonHang") })
        .then((res) => {
          setTicket(res.data);
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err);
        })
      })();
    }, []);
    const [showPassenger, setShowPassenger] = useState(false);
    const handleOnClose = () => {
        setShowPassenger(false);
    }
    const quantityOfTicket = ticket.length;
    const navigate = useNavigate();
    const getTicket = () => {
        let content = [];
        for (let i = 0; i < quantityOfTicket; i++) {
          content.push(
          <div className="border border-gray-300 p-6 grid grid-cols-3 gap-3 bg-white shadow-lg rounded-lg">
            <div className="font-bold text-teal-600">Ticket ID: {ticket[i].MaDatVe}</div>
            <div className="font-semibold">{ticket[i].Ngay.split('T')[0]}</div>
            <div className="font-semibold"></div>
            <div className="font-semibold">Flight ID: {ticket[i].MaSoChuyenBay} </div>
            <div className="font-semibold ">Departure: {ticket[i].DiaDiemXuatPhat}</div>
            <div className="font-semibold ">Arrival: {ticket[i].DiaDiemHaCanh}</div>
            <div className="flex "><button onClick={()=>{
              setGo(true);
              localStorage.setItem("Ticket ID", ticket[i].MaDatVe);
              setShowPassenger(true)}}><img src="/ticket.svg" className="h-10" /></button>
            </div>
            <div className="font-semibold">{ticket[i].ThoiGianXuatPhat.split('T')[1].split('.000Z')[0] }</div>
            <div className="font-semibold">{ticket[i].ThoiGianHaCanh.split('T')[1].split('.000Z')}</div>
            <div className="font-semibold">List of Passengers</div>
          </div>
          )
        }
    return content
    }
    const handleLogout = () =>{
      cookie.remove("token");
      cookie.remove("role");
      localStorage.clear();
      navigate('/');
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
                    onClick={() => {
                      localStorage.removeItem("MaDonHang")
                      navigate('/cart')
                    }}
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
        <div className="text-center font-bold font-serif py-7 text-3xl">All your tickets are here</div>
        <div className="text-start font-medium font-serif text-lg md:mx-20"> Number of plane tickets: {quantityOfTicket}</div>
        <div className="container my-7 mx-auto grid grid-cols-2 gap-20 justify-center items-center p-2 md:p-0">          
            {getTicket()}
        </div>
        <div className="text-start font-medium font-serif text-lg md:mx-20"> Number of room tickets: 0</div>
        <div className="container my-7 mx-auto grid grid-cols-2 gap-20 justify-center items-center p-2 md:p-0">          
        </div>
        <div className="text-start font-medium font-serif text-lg md:mx-20"> Number of restaurant tickets: 0</div>
        <div className="container my-7 mx-auto grid grid-cols-2 gap-20 justify-center items-center p-2 md:p-0">          
        </div>
        {/* <PassengerListOrder visible={showPassenger} onClose={handleOnClose}/> */}
        {localStorage.getItem("Ticket ID")?<PassengerListOrder visible={showPassenger} onClose={handleOnClose}/>:null}
      </section>
    </>
    )
}