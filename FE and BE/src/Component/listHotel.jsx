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
    name: 'TID',
    accessor: 'MaSoThueKhachSan',
  },
  {
    name: 'Hotel name',
    accessor: 'TenKhachSan',
  },
  {
    name: 'City',
    accessor: 'ThanhPho',
  },
  {
    name: 'Address',
    accessor: 'DiaChi',
  },
  {
    name: 'Description',
    accessor: 'MoTa',
  },
  {
    name: 'Type Room',
    accessor: 'LoaiPhong',
  },
  {
    name: 'Price',
    accessor: 'GiaPhong',
  },
  {
    name: 'Quantity',
    accessor: 'SoLuongCungCap',
  },
  {
    name: 'RestHotel',
    accessor: 'RestHotel',
  }
];
export default function ListHotel() {
    const cookie = new Cookies();
    const [hotel,setHotel] = useState([])
    useEffect(()=>{
      ( async () => {
        const current = JSON.parse(localStorage.getItem('currentHotel')).hotels
        const data = {
            token: cookie.get("token"),
            checkInDate: current[0].checkInDate,
            checkOutDate: current[0].checkOutDate,
            city: current[0].city
        }
        await axios.post('http://localhost:5000/room', data).then((res) => {
           console.log(res.data.rooms)
           setHotel(res.data.rooms)
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
            <h2 className="text-4xl font-bold tracking-wider text-white sm:text-3xl place-content-center text-center font-serif "> Amidst the chaos of life, find solace in the simplicity of relaxation.<br/> It's not a luxury; it's a necessity for a balanced and fulfilling existence.</h2>
          </div>
        </div>
      </section>
      <section>
        <div className="text-center text-3xl font-serif font-semibold py-5">
          Available hotel rooms
        </div>
        <div className="mx-96 text-center mb-20 mt-10 ">
          <Table columns={columns} data={hotel}/>
        </div>
      </section>
    </>
    )
}