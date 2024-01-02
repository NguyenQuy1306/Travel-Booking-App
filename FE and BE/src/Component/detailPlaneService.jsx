import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import Cookies from "universal-cookie";
import axios from "axios";
import Table from "../Utils/Table";

const columnsRev = [
  {
    Header: "Month",
    accessor: "Thang",    
  }
  ,
  {
    Header: "Revenue",
    accessor: "TongDoanhThuThang",
  }
];
const columnsFlight = [
  {
    Header: "Name",
    accessor: "TenHang",
  },
  {
    Header: "ID",
    accessor: "MaSoChuyenBay",
  },
  {
    Header: "Cabin Type",
    accessor: "LoaiKhoang",
  },
  {
    Header: "number of ticket",
    accessor: "SoLuongNguoiThamGia",
  },
  {
    Header: "Total Revenue",
    accessor: "TongTienVeThuDuoc",
  }
]
export default function DetailPlane() {
    const cookie = new Cookies();
   
    const navigate = useNavigate();
    const [year, setYear] = useState(2000);
    const [Revenue, setRevenue] = useState([]);
    const [date, setDate] = useState("");
    const [ticket, setTicket] = useState([]);
    const handleYear = (e) => {
      const date = new Date();
      const now = date.getFullYear();
      // < 2000 || > year
      console.log(year);
      if (year > now) {
        alert("Please enter a valid year in past");
        return;
      }
      axios.post("http://localhost:5000/revenue", { token: cookie.get("token"), airline:localStorage.getItem("name"), year: year }).then((res) => {
        console.log(res.data.revenue);
        const Revenue = [
          {
            "Thang": 1,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 2,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 3,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 4,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 5,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 6,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 7,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 8,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 9,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 10,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 11,
            "TongDoanhThuThang": 0,
          },
          {
            "Thang": 12,
            "TongDoanhThuThang": 0,
          },
        ]
        for (let i = 0; i < res.data.revenue.length; i++) {
          Revenue[res.data.revenue[i].Thang].TongDoanhThuThang = res.data.revenue[i].TongDoanhThuThang;
        }
        setRevenue(Revenue);
      })
      .catch((err) => {
        console.log(err);
      });
    }
    const handleFlight = (e) => {
      if (date === "") {
        alert("Please enter a valid date");
        return;
      }
      const now = new Date();
      const dateArr = date.split("-");
      const dateStr = dateArr[0] + "-" + dateArr[1] + "-" + dateArr[2];
      console.log(dateStr);
      axios.post("http://localhost:5000/numberPassengerOfAirline", { token: cookie.get("token"), airline:localStorage.getItem("name"), date: dateStr }).then((res) => {
        console.log(res.data);
        const temp = res.data.numberPassenger;
        for(let i = 0; i < temp.length; i++){
          temp[i].TongTienVeThuDuoc = new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(temp[i].TongTienVeThuDuoc);
        }
        setTicket(temp);
      }
      ).catch((err) => {
        console.log(err);
      });
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
                      localStorage.removeItem("name")
                      navigate('/provider/ManagerService')
                    }}
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
            <h2 className="text-xl font-bold tracking-wider text-white sm:text-xl place-content-center text-center font-serif "> "Triumph carved from resilience, persistence, and a relentless pursuit of dreams</h2>
          </div>
        </div>
      </section>
      <section>
        <div className="text-center font-bold font-serif py-7 text-3xl">Details of your child - {localStorage.getItem("name")}</div>
        <div className="grid grid-cols-2">
        <div className="text-start font-semibold font-serif text-lg md:mx-20 my-3">
        Revenue of your plane at Year:
          <input type="number" min = "2000" max = "2021" 
          onChange={(e)=>setYear(e.target.value)}
          value = {year}
          className="border border-gray-300 rounded-md p-2 ml-5" placeholder="Year" />
          <button 
          onClick={handleYear}
          className="bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded ml-5">Search</button>
          <Table columns={columnsRev} data={Revenue} />
        </div>
       
        <div className="text-start font-semibold font-serif text-lg md:mx-20">
          Details of your plane at date:
          <input type="date" 
          onChange={(e)=>setDate(e.target.value)}
          className="border border-gray-300 rounded-md p-1 ml-5 my-3" placeholder="Search" />
          <button 
            onClick={handleFlight}
          className="bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded ml-5">Search</button>
          <Table columns={columnsFlight} data={ticket} />
        </div>
        </div>
      
      </section>
    </>
    )
}