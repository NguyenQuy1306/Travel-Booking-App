import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import Table from "../Utils/Table";
import Cookies from "universal-cookie";
import axios from "axios";
import GeneralPlane from "../Utils/PopupGeneralPlane";

const columnPlane = [
    {
        Header: "TIN",
        accessor: "MaSoThue",
    },
    {
        Header: "Name",
        accessor: "TenHang",
    },
    {
        Header: "Description",
        accessor: "MoTa", 
    },
    {
        Header: "Phone number",
        accessor: "SoDienThoaiTuVanVien",
    },
    {
        Header: "Details",
        accessor: "DetailsRevenue",
    },
    {
        Header: "Update",
        accessor: "Update",
    },
    {
        Header: "Modify",
        accessor: "Modify",
    },
    {
        Header: "Delete",
        accessor: "DeleteSerive",
    },
]
const columnHotel = [
  {
    Header: "TIN",
    accessor: "MaSoThue",
},
{
    Header: "Name",
    accessor: "TenKhachSan",
},
{
    Header: "City",
    accessor: "ThanhPho",
},
{
    Header: "Phone number",
    accessor: "SoDienThoaiLeTan",
},
{
    Header: "Update",
    accessor: "Update",
},
{
    Header: "Modify",
    accessor: "Modify",
},
{
    Header: "Delete",
    accessor: "DeleteSerive",
},
]

export default function ManagerService() {
    const cookie = new Cookies();
    const navigate = useNavigate();
    const [showPopup, setShowPopup] = useState(false);
    const handlePopup = () => {
        setShowPopup(false);
    }
    const [plane,setPlane] = useState([]);
    const [hotel,setHotel] = useState([]);
    useEffect(() => {
      (async () => {
        axios.post("http://localhost:5000/getFlightService", { token: cookie.get("token")})
        .then((res) => {
          console.log(res.data.flightService);
          setPlane(res.data.flightService)
        })
        .catch((err) => {
          console.log(err);
        })
        axios.post("http://localhost:5000/getHotelService", { token: cookie.get("token") })
        .then((res) => {
          console.log(res.data.hotelService);
          setHotel(res.data.hotelService)          
        })
      })();
    }, []);
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
                    onClick={() => navigate('/provider')}
                    className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">
                        <img src="/arrow-left.svg" className="h-8" />
                    </button>
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
            <h2 className="text-xl font-bold tracking-wider text-white sm:text-3xl place-content-center text-center font-serif "> 'Success is not final, failure is not fatal: It is the courage to continue that counts.'</h2>
            <h2 className="text-2xl font-bold tracking-wider text-white sm:text-xl place-content-center text-center font-serif pt-7">  Here's to our manager, leading us with unwavering courage towards new horizons and triumphs.</h2>
          </div>
        </div>
      </section>
      <section>
        <div className="text-center font-bold font-serif py-7 text-3xl">Manage your service</div>
        <div className="text-center font-medium font-serif text-lg md:mx-20"> 
        Number of airplane service: {plane.length} <button onClick={()=>setShowPopup(true)} className="bg-teal-400 hover:bg-teal-600 text-white font-bold py-2 px-4 rounded ml-5">General Information</button>
        </div>
        <div className="container my-7 mx-auto grid grid-cols-1 gap-20 justify-center items-center p-2 md:p-0">     
            <div className="border border-gray-300 p-6 grid grid-cols-1 gap-6 bg-white shadow-lg rounded-lg ">     
                <Table columns={columnPlane} data={plane} />
            </div>
        </div>
        <div className="text-center font-medium font-serif text-lg md:mx-20"> 
        Number of hotel service: {hotel.length}<button className="bg-teal-400 hover:bg-teal-600 text-white font-bold py-2 px-4 rounded ml-5">General Information</button>
        </div>
        <div className="container my-7 mx-auto grid grid-cols-1 gap-20 justify-center items-center p-2 md:p-0">   
           <div className="border border-gray-300 p-6 grid grid-cols-1 gap-6 bg-white shadow-lg rounded-lg ">     
                <Table columns={columnHotel} data={hotel} />
            </div>       
        </div>
        <div className="text-center font-medium font-serif text-lg md:mx-20"> 
        Number of restaurant service: 0<button className="bg-teal-400 hover:bg-teal-600 text-white font-bold py-2 px-4 rounded ml-5">General Information</button>
        </div>
        <div className="container my-7 mx-auto grid grid-cols-1 gap-20 justify-center items-center p-2 md:p-0">          
        </div>
      <GeneralPlane visible={showPopup} onClose={handlePopup}/>
      </section>
    </>
    )
}