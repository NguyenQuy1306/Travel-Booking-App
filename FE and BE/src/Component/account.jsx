import React, {useEffect, useState} from "react";  
import { useNavigate } from "react-router-dom";
import BankingForm from "../Utils/PopupBanking";
import Table from "../Utils/Table";
import Cookies from "universal-cookie";
import axios from "axios";

const Order = [
  {"id": "001", "status" : "pending", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2021-10-10", "assistant" : "John"},
  {"id": "002", "status" : "pending", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2021-11-10", "assistant" : "John"},
  {"id": "003", "status" : "done", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2021-10-10", "assistant" : "John"},
  {"id": "004", "status" : "pending", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2022-10-10", "assistant" : "John"},
  {"id": "005", "status" : "pending", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2021-10-10", "assistant" : "John"},
  {"id": "006", "status" : "pending", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2023-8-10", "assistant" : "John"},
  {"id": "007", "status" : "done", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2021-10-10", "assistant" : "John"},
  {"id": "008", "status" : "pending", "payment_method" : "visa", "number" : "123456789", "total" : "1000$", "date" : "2021-10-10", "assistant" : "John Alexander Hamilton"},
]
const columns = [
  {
    name: 'ID',
    accessor: 'id',
  },
  {
    name: 'Payment method',
    accessor: 'payment_method',
  },
  {
    name: 'Number',
    accessor: 'number',
  },
  {
    name: 'Date',
    accessor: 'date',
  },
  {
    name: 'Total',
    accessor: 'total',
  },
  {
    name: 'Assistant',
    accessor: 'assistant',
  },
];

export default function Account() {
  const cookie = new Cookies();
  const HistoryOrder = Order.filter((order) => order.status === "done");
  const [showBankingForm, setShowBankingForm] = useState(false);
  const handleOnClose = () => setShowBankingForm(false);
   const navigate = useNavigate();
    const handleLogout = () =>{
      cookie.remove("token");
      cookie.remove("role");
      localStorage.clear();
      navigate('/');
    }
    const [profile, setProfile] = useState({});
    const [loading, setLoading] = useState(false);
    useEffect(() => {
      (async () => {
        axios.post("http://localhost:5000/profile", {token:cookie.get("token")})
        .then((res) => {
          console.log(res.data)
          setProfile(res.data[0])
          setLoading(true)
        })
        .catch((err) => {
          console.log(err)
        })

      }
      )();
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
                  <button  
                  onClick={() => navigate('/cart')}
                  className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">
                    <img src="cart-shopping.svg" className="h-8" />
                  </button>
                </li>
                <li>
                  <button onClick={() => navigate('/user')} className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Take a trip</button>
                </li>
                <li>
                  <a href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Your promotion</a>
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
            <h2 className="text-4xl font-bold tracking-wider text-white sm:text-7xl place-content-center text-center font-serif ">Hello, {profile.Ten} </h2>
          </div>
        </div>
      </section>
      <section className="flex">
        <div className="w-full justify-center text-center mt-16 mb-5">
          <div className="flex justify-center"><img src="vip2.svg" className="h-28 md:h-52 justify-center text-center"></img></div>
          <div className="text-3xl font-medium">
            VIP 2
          </div>
          <div className="text-xl font-medium">
            Total consumption: 1000$
          </div>
          <div className="text-lg fon-base">
            Reach 2000$ to upgrade to VIP 3
          </div>
        </div>
        <div>
        </div>
        <div className="text-center pb-10 justify-center w-full">
          <img src="/avatar.jpg" className="md:h-72 h-48 rounded-full mx-auto mt-10 mb-5" />
          <button className="bg-gray-500 text-gray-200 hover:bg-gray-400 text-base p-1 rounded-3xl ">Change</button>          
        </div>
        <div className="w-full justify-center">
          <div className="flex pt-8">
            <div className="px-2">
              <input className="bg-gray-200 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" disabled="true" placeholder="Your Name: "></input>
            </div>
            <div className="px-2">
              <input 
              value={profile.Ho}
              className="bg-gray-100 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" placeholder="First name"></input>
            </div>
            <div className="px-2">
              <input
              value={profile.TenDem}
              className="bg-gray-100 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" placeholder="Middle name"></input>
            </div>
            <div className="px-2">
              <input 
              value={profile.Ten}
              className="bg-gray-100 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" placeholder="Last name"></input>
            </div>
          </div>
          <div className="flex justify-start pt-10">
            {/* date of birth */}
            <div className="px-2">
              <input 
              className="bg-gray-200 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" disabled="true" placeholder="Date of birth: "></input>
            </div>
            <div className="px-2">
            <input 
              value={(loading)?profile.NgaySinh.split("T")[0]:null}
            type="date" className="bg-gray-100 rounded-xl p-2 justify-center text-center font-medium w-36" 
            onFocus={(e) => (e.currentTarget.type = "date")}
            onBlur={(e) => (e.currentTarget.type = "text")}
            placeholder="Date of birth"></input>
            </div>
          </div>
          <div className="flex justify-start pt-10">
            {/* Sex */}
            <div className="px-2">
              <input className="bg-gray-200 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" disabled="true" placeholder="Sex: "></input>
            </div>
            <div className="px-2">
                <select className="bg-gray-100 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" value="male">
                  <option>male</option>
                  <option>female</option>
                  <option>other</option>
                </select>
            </div>
          </div>
          <div className="flex justify-start pt-10">
            <div className="px-2">
              <input 
              value = {profile.soCCCD}
              className="bg-gray-200 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center" disabled="true" placeholder="CCCD: "></input>
            </div>
            <div className="px-2">
               <input type="text" className="bg-gray-100 rounded-xl p-2 md:w-36 w-20 text-center font-medium justify-center" placeholder="012345678999" disabled="true"></input>
            </div>
          </div>
          <div className="flex justify-start pt-10">
            <div className="px-2">
              <button 
              onClick={() => setShowBankingForm(true)}
              className="bg-gray-200 rounded-xl p-2 md:w-28 w-20 text-center font-medium justify-center">Payment</button>
            </div>
            <BankingForm visible={showBankingForm} onClose={handleOnClose} />
          </div>
        </div>
      </section>
      <hr/>
      <section>
        <div className="text-center text-3xl pt-5 md:text-5xl font-medium font-serif">
          Your order history
        </div>
        <div className="mx-96 text-center mb-20 mt-10">
          <Table columns={columns} data={HistoryOrder} />
        </div>
      </section>

      </>
    );
}