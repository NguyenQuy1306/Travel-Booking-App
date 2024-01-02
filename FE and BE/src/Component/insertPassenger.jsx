import React from "react";
import { useNavigate } from "react-router-dom";
import { useState, useEffect } from "react";
import Cookies from "universal-cookie";
import axios from "axios";

export default function InsertPassenger() {
    const cookie = new Cookies();
    const navigate = useNavigate();
    const quantityOfPassenger = JSON.parse(localStorage.getItem("currentFlight")).flights[0].SoLuong
    const [typeCabins, setTypeCabins] = useState([]);
    const [total,setTotal] = useState(0);
    

    useEffect(()=>{
      ( async () => {
        const current = JSON.parse(localStorage.getItem('currentFlight')).flights
        const data = {
        token: cookie.get("token"),
        startDate: current[0].NgayXuatPhat,
        deptLoc: current[0].NoiXuatPhat,
        destLoc: current[0].NoiHaCanh,
        quantity: current[0].SoLuong
        }
        const res = await axios.post('http://localhost:5000/flight', data)
        const temp = []
        for (let i = 0; i < res.data.flights.length; i++) {
          if (res.data.flights[i].MaSoMayBay === localStorage.getItem('MaSoMayBay')){
            temp.push({type: res.data.flights[i]['LoaiKhoang'], price: res.data.flights[i]['GiaKhoang']})
          }
        }
        setTypeCabins(temp)
      })()
    },[])
    const generateInitialData = (count) => Array.from({ length: count }, () => ({
      flightID: localStorage.getItem('MaSoMayBay'),
      name: undefined,
      phonenumber: undefined,
      email: undefined,
      CCCD: undefined,
      birthday: undefined,
      cabinType: undefined,
      Price: 0,
    }));
    const [passenger, setPassenger] =  useState(() => generateInitialData(quantityOfPassenger));
    useEffect(() => {
      let temp = 0;
      for (let i = 0; i < quantityOfPassenger; i++) {
        temp += passenger[i].Price;
      }
      setTotal(temp);
    }, [passenger])
    const getForm = () => {
      let content = [];
      for (let i = 0; i < quantityOfPassenger; i++) {
        content.push(
        <div className="border border-gray-300 p-6 grid grid-cols-1 gap-3 bg-white shadow-lg rounded-lg">
          <div className="font-bold text-teal-600">Passenger {i}</div>
          <div className="font-semibold">Full name: <input 
            onChange={(e) => {
              setPassenger((prevData) => [
                ...prevData.slice(0, i),
                { ...prevData[i], name: e.target.value },
                ...prevData.slice(i + 1),
              ]);
            }
          }
            value={passenger[i].name}
          type="text" placeholder="Full name"
           className="p-1 font-normal"/></div>
          
          <div className="font-semibold">Phone number: <input
            onChange={(e) => {
              setPassenger((prevData) => [
                ...prevData.slice(0, i),
                { ...prevData[i], phonenumber: e.target.value },
                ...prevData.slice(i + 1),
              ]);
            }
          }
          type="text" placeholder="Phone number" className="p-1 font-normal" /></div>

          <div className="font-semibold">Email: <input
            onChange={(e) => {
              setPassenger((prevData) => [
                ...prevData.slice(0, i),
                { ...prevData[i], email: e.target.value },
                ...prevData.slice(i + 1),
              ]);
            }
          }
            value={passenger[i].email}
          type="email" placeholder="Email" className="p-1 font-normal"/></div>

          <div className="font-semibold">CID: <input 
            onChange={(e) => {
              setPassenger((prevData) => [
                ...prevData.slice(0, i),
                { ...prevData[i], CCCD: e.target.value },
                ...prevData.slice(i + 1),
              ]);
            }
          }
          type="text" placeholder="CID"  className="p-1 font-normal"/></div>

          <div className="font-semibold">Birthday: <input
            onChange={(e) => {
              setPassenger((prevData) => [
                ...prevData.slice(0, i),
                { ...prevData[i], birthday: e.target.value },
                ...prevData.slice(i + 1),
              ]);
            }
          }
          value={passenger[i].birthday}
          type="date"  className="p-1  font-normal"/></div>

          <div className="grid grid-cols-2">
            <div className="font-semibold">Cabin type: 
              <select 
              onChange={(e) => {
                setPassenger((prevData) => [
                  ...prevData.slice(0, i),
                  { ...prevData[i], cabinType: e.target.value },
                  ...prevData.slice(i + 1),
                ]);
                setPassenger((prevData) => [
                  ...prevData.slice(0, i),
                  { ...prevData[i], Price: typeCabins.find(item => item.type === e.target.value).price },
                  ...prevData.slice(i + 1),
                ]);
              }
            }
            value={passenger[i].cabinType}
              className=" p-1 font-normal">
                <option value disabled selected hidden>Choose </option>
                {
                  typeCabins.map((item) => {
                    return <option value={item.type}>{item.type}</option>
                  }
                  )
                }
              </select>
            </div>  
            <div className="font-semibold flex py-1">
              Luggages type
              <button
              ><img src="/luggage.svg" className="h-8 px-3" /></button>
            </div>
            <div className="font-semibold py-1">Price: {passenger[i].Price}$</div>
            <div className="font-semibold py-1">Price: 0$</div>
          </div>
          <div className="font-semibold py-1 justify-center text-teal-600">
            <span className="font-serif font-semibold"> Total: </span> {new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(passenger[i].Price)}
          </div>
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
    const handleSubmit = () => {
      console.log(passenger)
      const check =[]
      for (let i = 0; i < quantityOfPassenger; i++) {
        if(passenger[i].name === undefined || passenger[i].phonenumber === undefined || passenger[i].email === undefined || passenger[i].CCCD === undefined || passenger[i].birthday === undefined || passenger[i].cabinType === undefined){
          check.push(i)
        }
        // check name valid %[^a-zA-Z ]%
        if(passenger[i].name !== undefined){
          if(passenger[i].name.match(/[^a-zA-Z ]/g)){
            alert("Please fill the correct name for passenger " + i)
            return ;
          }
        }          
        if(passenger[i].phonenumber !== undefined){
          if(isNaN(passenger[i].phonenumber) || passenger[i].phonenumber.length < 7 || passenger[i].phonenumber.length > 11){
            alert("Please fill the correct phonenumber for passenger " + i)
            return ;
          }
        }
        if(passenger[i].email !== undefined){
          const checkEmail = passenger[i].email.split('@')
          if(checkEmail.length !== 2){
            alert("Please fill the correct email for passenger " + i)
            return ;
          }
        }
        // check leng = 12 
        if(passenger[i].CCCD !== undefined){
          if(passenger[i].CCCD.length !== 12){
            alert("Please fill the correct CID for passenger " + i)
            return ;
          }
        }
        // check age < 3
        if(passenger[i].birthday !== undefined){
          let today = new Date();
          let birthDate = new Date(passenger[i].birthday);
          let age = today.getFullYear() - birthDate.getFullYear();
          let m = today.getMonth() - birthDate.getMonth();
          if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
              age--;
          }
          if(age < 3){
            alert("The baby under 3 years old must be accompanied by an adult.")
            return ;
          }
        }
      }
      if (check.length !== 0){
        alert("Please fill all the information for passenger " + check)
        return;
      }
      // we will put this information and id plane to local storage.
      const data = {
        ticket: JSON.parse(localStorage.getItem('currentFlight')).flights[0],
        passenger: passenger,
        total: total,
        flightID: localStorage.getItem('MaSoMayBay'),
        timeDeparture: localStorage.getItem('ThoiGianXuatPhat'),
        timeArrival: localStorage.getItem('ThoiGianHaCanh'),
        departure: localStorage.getItem('DiaDiemXuatPhat'),
        arrival: localStorage.getItem('DiaDiemHaCanh'),
      }
      if (localStorage.getItem('ticket') === null){
        localStorage.setItem('ticket', [JSON.stringify([data])])
      }
      else{
        const temp = JSON.parse(localStorage.getItem('ticket'))
        temp.push(data)
        localStorage.setItem('ticket', JSON.stringify(temp))
      }
      localStorage.removeItem('MaSoMayBay')
      localStorage.removeItem('ThoiGianXuatPhat')
      localStorage.removeItem('ThoiGianHaCanh')
      localStorage.removeItem('DiaDiemXuatPhat')
      localStorage.removeItem('DiaDiemHaCanh')
      navigate('/user')
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
                      localStorage.removeItem('MaSoMayBay')
                      localStorage.removeItem('ThoiGianXuatPhat')
                      localStorage.removeItem('ThoiGianHaCanh')
                      localStorage.removeItem('DiaDiemXuatPhat')
                      localStorage.removeItem('DiaDiemHaCanh')
                      navigate('/user/listPlane')
                      }
                    }
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
            <h2 className="text-4xl font-bold tracking-wider text-white sm:text-3xl place-content-center text-center font-serif "> "Join the Journey: Let's Make Memories Together!"</h2>
          </div>
        </div>
      </section>
      <section>
        <div className="text-center text-4xl font-semibold font-serif p-3">Fill your information</div>
        <div className="container my-7 mx-auto grid grid-cols-3 gap-20 justify-center items-center p-2 md:p-0">          
            {getForm()}
        </div>
      </section>
      <section>
        <div className="text-center pb-5 text-2xl"><span className="font-serif font-semibold">Total cost </span>: {new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(total)}</div>
        <div className="text-center">
          {/* submit */}
          <button 
            onClick={handleSubmit}
          className="bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded-full text-2xl">
            Submit
          </button>
         </div>
      </section>
    </>
    )
}