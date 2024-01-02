import React, { useEffect, useState } from "react";  
import { useNavigate } from "react-router-dom";
import Table from "../Utils/Table";
import Cookies from "universal-cookie";
import axios from "axios";

// const service = [
//     {
//         ID: 1,
//         name: "Plane",
//         status: "Active",
//         link: "https://planewre.com"
//     },
//     {
//         ID: 2,
//         name: "Hotel",
//         status: "Active",
//         link: "https://hotelwre.com"
//     },
//     {
//         ID: 3,
//         name: "Restaurant",
//         status: "Active",
//         link: "https://restaurantwre.com"
//     }
// ]

const columns = [
    {
        Header: "ID",
        accessor: "tin"
    },
    {
        Header: "Name",
        accessor: "name"
    },
    {
        Header: "Type",
        accessor: "type"
    },
    
]

export default function Provider() {
    const cookie = new Cookies();
    const navigate = useNavigate();
    const handleLogout = () =>{
      cookie.remove("token");
      cookie.remove("role");
      localStorage.clear();
      navigate('/');
    }
    const [service, setService] = useState([]);
    useEffect(() => {
      (async () => {
        const dataColumn = ["tin","name","type"]
        const showData = []
        axios.post("http://localhost:5000/getFlightService", { token: cookie.get("token") })
        .then((res) => {
          console.log(res.data.flightService);
          let temp = {}
          for (let i = 0; i < res.data.flightService.length; i++) {
            temp = {}
            temp[dataColumn[0]] = res.data.flightService[i].MaSoThue;
            temp[dataColumn[1]] = res.data.flightService[i].TenHang;
            temp[dataColumn[2]] = res.data.flightService[i].LoaiDichVu;
            showData.push(temp);
          }
        })
        .catch((err) => {
          console.log(err);
        })
        axios.post("http://localhost:5000/getHotelService", { token: cookie.get("token") })
        .then((res) => {
          console.log(res.data.hotelService);
          let temp = {}
          for (let i = 0; i < res.data.hotelService.length; i++) {
            temp = {}
            temp[dataColumn[0]] = res.data.hotelService[i].MaSoThue;
            temp[dataColumn[1]] = res.data.hotelService[i].TenKhachSan;
            temp[dataColumn[2]] = res.data.hotelService[i].LoaiDichVu;
            showData.push(temp);
            setService(showData);
          }
        })
        .catch((err) => {
          console.log(err);
        })
      })();
    }, [])
    
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
                  <a href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">What news ?</a>
                </li>
                <li>
                  <button href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Account</button>
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
            <h2 className="text-4xl font-bold tracking-wider text-white sm:text-6xl place-content-center text-center font-serif ">Welcoming back our <span className="text-amber-200">invaluable</span>  business partner!</h2>
            <p className="mt-6 text-xl leading-8 text-gray-300 text-center "> 
                <span className="text-2xl font-bold font-serif"> Your return brings a <span className="text-yellow-200">renewed</span> energy to our <span className="text-blue-300">collaboration.</span></span> <br/>
            </p>
           <p className="text-3xl font-bold font-serif text-center text-white pt-10">Let's achieve new heights together! </p>

          </div>
        </div>
        
      </section>
      <section className="grid grid-cols-2 p-10">
        <div className="grid grid-cols-2 gap-10">
            <div className="container my-7 mx-auto flex justify-center items-center p-2 md:p-0">
                <button><div className="hover:bg-gray-200 text-3xl font-serif font-semibold border border-gray-300 p-6 grid grid-cols-1 gap-6 bg-gray-300 shadow-lg rounded-lg  lg:w-[300px] md:w-[200px] h-[200px] place-content-center text-center">
                    Add new service
                </div>
                </button>
            </div>
            <div className="container my-7 mx-auto flex justify-center items-center p-2 md:p-0">
                <button
                    onClick={() => navigate('/provider/managerService')}
                ><div className="hover:bg-gray-200 text-3xl font-serif font-semibold border border-gray-300 p-6 grid grid-cols-1 gap-6 bg-gray-300 shadow-lg rounded-lg  lg:w-[300px] md:w-[200px]  h-[200px] place-content-center text-center">
                    Management services
                </div>
                </button>
            </div>
            <div className="container my-7 mx-auto flex justify-center items-center p-2 md:p-0">
                <button><div className="hover:bg-gray-200 text-3xl font-serif font-semibold border border-gray-300 p-6 grid grid-cols-1 gap-6 bg-gray-300 shadow-lg rounded-lg  lg:w-[300px] md:w-[200px] h-[200px] place-content-center text-center">
                    Contact admin
                </div>
                </button>
            </div>
        </div>
        <div>
            <div className="text-center text-3xl font-serif font-medium">What you own</div>
            <div className="px-20">
                <Table columns={columns} data={service} />
            </div>      
        </div>
      </section>
      </>
    );
}