import React, {useEffect, useState} from "react";  
import { useNavigate } from "react-router-dom";
import Table from "../Utils/Table";
import Cookies from "universal-cookie";
import axios from "axios";

const columns = [
  {
    name: "Order ID",
    accessor: "MaDonHang",
  }
  ,
  {
    name: "Payment Method",
    accessor: "HinhThucThanhToan",
  },
  {
    name: "Payment number",
    accessor: "TaiKhoanNganHang",
  },
  {
    name: "Date Order",
    accessor: "NgayGiaoDich",
  },
  {
    name: "Status",
    accessor: "TinhTrangDonHang"
  },
  {
    name: "Total",
    accessor: "TongTien",
  },
  {
    name: 'Detail',
    accessor: 'Detail',
  },
  {
    name: 'Delete',
    accessor: 'delete',
  },
];

export default function Cart() {
  const cookie = new Cookies();
  const [Order, setOrder] = useState([]);
  const currentOrder = Order;
  const [showBankingForm, setShowBankingForm] = useState(false);
  const handleOnClose = () => setShowBankingForm(false);
   const navigate = useNavigate();
    const handleLogout = () =>{
      cookie.remove("token");
      cookie.remove("role");
      localStorage.clear();
      navigate('/');
    }
    useEffect(() => {
      (async () => {
        axios.post("http://localhost:5000/getOrder", {token:cookie.get("token")})
        .then((res) => {
          console.log(res.data)
          const temp = res.data.map((item) => {
            const newTime = item.NgayGiaoDich.split('T')[0]
            return {...item,NgayGiaoDich:newTime}
          })
          setOrder(temp);
        })
        .catch((err) => {
          console.log(err)
        })
      })();
    }, []);
    
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
                  <button onClick={() => navigate('/user')} className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Take a trip</button>
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
        <div className="text-center text-3xl pt-5 md:text-5xl font-medium font-serif">
          Your order 
        </div>
        <div className="mx-96 text-center mb-20 mt-10">
          <Table columns={columns} data={currentOrder} />
        </div>
      </section>

      </>
    );
}