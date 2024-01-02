import React from "react";
import { useNavigate } from "react-router-dom";
import Table from "../Utils/Table";
import {useState , useEffect} from 'react';
import Cookies from 'universal-cookie';
import axios from 'axios'

// const Plane = [
//   {"MaSo": "VNA001", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA002", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA003", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA004", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA005", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA006", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA007", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA008", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA009", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
//   {"MaSo": "VNA0010", "Ngay": "2021-10-10", "ThoiGianXuatPhat": "10:00", "ThoiGianHaCanh": "12:00", "DiaDiemXuatPhat": "Ho Chi Minh", "DiaDiemHaCanh":"Ha Noi"},
// ]
const columns = [
  {
    name: 'ID',
    accessor: 'MaSoMayBay',
  },
  {
    name: 'Departure',
    accessor: 'DiaDiemXuatPhat',
  },
  {
    name: 'Arrival',
    accessor: 'DiaDiemHaCanh',
  },
  {
    name: 'Datetime departure',
    accessor: 'ThoiGianXuatPhat',
  },
  {
    name: 'Datetime arrival',
    accessor: 'ThoiGianHaCanh',
  },
  {
    name: 'Price',
    accessor: 'GiaKhoang',
  },
  {
    name: 'Choose plane',
    accessor: 'ChoosePlane',
  },
];
export default function ListPlane() {
    const cookie = new Cookies();
    const [Plane,setPlane] = useState([])
    useEffect(()=>{
      ( async () => {
        const current = JSON.parse(localStorage.getItem('currentFlight')).flights
        const data = {
        token: cookie.get('token'),
        startDate: current[0].NgayXuatPhat,
        deptLoc: current[0].NoiXuatPhat,
        destLoc: current[0].NoiHaCanh,
        quantity: current[0].SoLuong
        }
        await axios.post('http://localhost:5000/flight', data).then((res) => {
           console.log(res)
        // the Plane data have datetime in time arrival and departure column, so we need to convert it to time only
        const newPlane = res.data.flights.map((item) => {
          const newTime = item.ThoiGianXuatPhat.split('T')[1].split('.')[0]
          const newTime2 = item.ThoiGianHaCanh.split('T')[1].split('.')[0]
          return {...item,ThoiGianXuatPhat:newTime,ThoiGianHaCanh:newTime2}
        })
        // Cause the plane can be duplicate, so we need to remove it, we only choose the plane of each airline which have the lowest price
        const newPlane2 = []
        for(let i = 0; i < newPlane.length; i++){
          let check = true
          for(let j = 0; j < newPlane2.length; j++){
            if(newPlane[i].MaSoMayBay === newPlane2[j].MaSoMayBay){
              check = false
              if(newPlane[i].GiaKhoang < newPlane2[j].GiaKhoang){
                newPlane2[j] = newPlane[i]
              }
            }
          }
          if(check){
            newPlane2.push(newPlane[i])
            newPlane[i].GiaKhoang = newPlane[i].GiaKhoang.toLocaleString('it-IT', {style : 'currency', currency : 'VND'})
          }
        }
        setPlane(newPlane2)
      }).catch((err) => {
        console.log(err);
      }
      );
      })();

    },[]);
    const navigate = useNavigate();
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
                      navigate('/user')}}
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
        <div className="mx-auto px-auto pb-7">
          <div className="grid">
            <h2 className="text-4xl font-bold tracking-wider text-white sm:text-3xl place-content-center text-center font-serif "> "The purpose of life is to live it, to taste experience to the utmost, to reach out eagerly and without fear for newer and richer experiences."</h2>
            <h2 className="text-center text-white font-serif text-3xl pt-5">- Eleanor Roosevelt -</h2>
          </div>
        </div>
      </section>
      <section>
        <div className="text-center text-3xl font-serif font-semibold py-5">
          Available flights
        </div>
        <div className="mx-96 text-center mb-20 mt-10 ">
          <Table columns={columns} data={Plane}/>
        </div>
      </section>
    </>
    )
}