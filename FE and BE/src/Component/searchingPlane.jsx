import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import 'react-tooltip/dist/react-tooltip.css'
import axios from "axios";



// the city in vietnam which have airport
const city = [
  "Ho Chi Minh City",
  "Hanoi",
  "Da Nang"
]

export default function SearchingPlane() {
    const navigate = useNavigate();
    const [planeData, setPlaneData] = useState({
      SoLuong : 0,
      NoiXuatPhat : "",
      NoiHaCanh : "",
      NgayXuatPhat : ""
    });
    useEffect(() => {
      if (localStorage.getItem('currentFlight') !== null) {
          const data = JSON.parse(localStorage.getItem('currentFlight')).flights[0];
          if (data !== null) {
              setPlaneData({
                SoLuong : data.SoLuong,
                NoiXuatPhat : data.NoiXuatPhat,
                NoiHaCanh : data.NoiHaCanh,
                NgayXuatPhat : data.NgayXuatPhat
              });
          }
      }
      else {
        setPlaneData({
          SoLuong : 0,
          NoiXuatPhat : "",
          NoiHaCanh : "",
          NgayXuatPhat : ""
        });
      }
    }, [localStorage.getItem('currentFlight')]);
    const handleFindPlane = () => {
      console.log(planeData);
      if (planeData.SoLuong == 0 ){
        alert("Please choose the quantity of passenger");
        return ;
      }
      if(planeData.NoiXuatPhat == "" || planeData.NoiHaCanh == "" || planeData.NgayXuatPhat == "") {
        alert("Please fill all the information");
        return ;
      }
      if (planeData.NoiXuatPhat == planeData.NoiHaCanh) {
        alert("Please choose the different city");
        return ;
      }
      const data = {
        SoLuong : planeData.SoLuong,
        NoiXuatPhat : planeData.NoiXuatPhat,
        NoiHaCanh : planeData.NoiHaCanh,
        NgayXuatPhat : planeData.NgayXuatPhat
      }
      localStorage.setItem("currentFlight", JSON.stringify({flights : [data]}));

      navigate("/user/listPlane");
    }
    return (
        <div >
          <div className="flex justify-center pt-3 text-3xl font-medium font-serif">Booking your trip</div>
          <div className="container my-7 mx-auto flex justify-center items-center p-2 md:p-0">
            <div className="border border-gray-300 p-6 grid grid-cols-1 gap-6 bg-white shadow-lg rounded-lg w-7/12">
              <div className="flex flex-col md:flex-row justify-between">
                <div className="w-full  justify-start ">
                  <button><label for="counter-input" class="block mb-1 text-sm font-medium text-gray-900 dark:text-white w-full">Choose quantity of your passengers:</label></button>
                  <div className="text-xs">Note: children under the age of 3 to fly free </div>
                  <div className="relative flex items-center px-16 pt-3">
                      <button onClick={()=>{
                        console.log(planeData)
                        if(planeData.SoLuong>0){
                          setPlaneData({...planeData, SoLuong : planeData.SoLuong - 1});
                        }
                      }} type="button" id="decrement-button" data-input-counter-decrement="counter-input" className="flex-shrink-0 bg-gray-100 dark:bg-gray-700 dark:hover:bg-gray-600 dark:border-gray-600 hover:bg-gray-200 inline-flex items-center justify-center border border-gray-300 rounded-md h-5 w-5 focus:ring-gray-100 dark:focus:ring-gray-700 focus:ring-2 focus:outline-none">
                          <svg className="w-2.5 h-2.5 text-gray-900 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 2">
                              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h16"/>
                          </svg>
                      </button>
                      <input type="text" id="counter-input" data-input-counter class="flex-shrink-0 text-gray-900 dark:text-white border-0 bg-transparent text-sm font-normal focus:outline-none focus:ring-0 max-w-[2.5rem] text-center" placeholder="" value={planeData.SoLuong} 
                      required/>
                      <button onClick={()=>{
                        if (planeData.SoLuong < 9){
                          setPlaneData({...planeData, SoLuong : planeData.SoLuong + 1});
                        }
                      }}type="button" id="increment-button" data-input-counter-increment="counter-input" className="flex-shrink-0 bg-gray-100 dark:bg-gray-700 dark:hover:bg-gray-600 dark:border-gray-600 hover:bg-gray-200 inline-flex items-center justify-center border border-gray-300 rounded-md h-5 w-5 focus:ring-gray-100 dark:focus:ring-gray-700 focus:ring-2 focus:outline-none">
                          <svg className="w-2.5 h-2.5 text-gray-900 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 18">
                              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 1v16M1 9h16"/>
                          </svg>
                      </button>
                  </div>
                </div>
                <div className="w-full flex justify-center ">
                  <button disabled="true"><img src="plane.svg" className="h-10" /></button>
                </div>
                <div className="w-full flex justify-end">
                  <button onClick={()=>navigate("/user/ticketPlane")}>
                    {
                      (localStorage.getItem("ticket") === null) ?<img src="ticket.svg" className="h-10" />:<img src="ticket-red.svg" className="h-10" />
                    }
                  </button>
                </div>

                
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="grid grid-cols-2 gap-2 border border-gray-200 p-2 rounded">
                  <div className="flex border rounded bg-gray-100 items-center p-2 ">
                    <img src="plane-departure.svg" className="px-2"/>
                    {/* the arrow of select is left side */}
                    <select dir="rtl" onChange={
                      (e)=>{
                        setPlaneData({...planeData, NoiXuatPhat : e.target.value});
                      }
                    } className="bg-gray-100 max-w-full focus:outline-none text-gray-700">
                      <option value= {(planeData.NoiXuatPhat === "") ? "From city" : planeData.NoiXuatPhat} disabled selected>
                      {(planeData.NoiXuatPhat === "") ? "From city" : planeData.NoiXuatPhat}
                      </option>
                      {   
                          city.map((item)=>{
                            return <option value={item}>{item}</option>
                          })
                      }
                    </select>
                  </div>
                  <div className="flex border rounded bg-gray-100 items-center p-2 ">
                    <img src="plane-arrival.svg" className="px-2"/>
                    <select dir="rtl" onChange={
                      (e)=>{
                        setPlaneData({...planeData, NoiHaCanh : e.target.value});
                      }
                    }  className="bg-gray-100 max-w-full focus:outline-none text-gray-700">
                      <option value={((planeData.NoiHaCanh === "") ? "To city" : planeData.NoiHaCanh)} disabled selected>
                        {((planeData.NoiHaCanh === "") ? "To city" : planeData.NoiHaCanh)}
                      </option>
                      {   
                          
                            city.map((item)=>{
                                if (item != planeData.NoiXuatPhat)
                                  return <option value={item}>{item}</option>
                                else 
                                  return <option value={item} disabled>{item}</option>
                              }
                            )
                      }
                    </select>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-2 border border-gray-200 p-2 rounded">
                  <div className="flex border rounded bg-gray-100 items-center p-2 ">
                    <svg className="fill-current text-gray-800 mr-2 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width={24} height={24}>
                      <path className="heroicon-ui" d="M14 5.62l-4 2v10.76l4-2V5.62zm2 0v10.76l4 2V7.62l-4-2zm-8 2l-4-2v10.76l4 2V7.62zm7 10.5L9.45 20.9a1 1 0 0 1-.9 0l-6-3A1 1 0 0 1 2 17V4a1 1 0 0 1 1.45-.9L9 5.89l5.55-2.77a1 1 0 0 1 .9 0l6 3A1 1 0 0 1 22 7v13a1 1 0 0 1-1.45.89L15 18.12z" />
                    </svg>
                    <input type="date" placeholder="Time Departure" className="bg-gray-100 w-32 h-7 focus:outline-none text-gray-700" 
                      onChange={
                        (e) =>
                        {
                          // check if the date is valid
                          var today = new Date();
                          var date = new Date(e.target.value);
                          if (date < today) {
                            alert("Please choose the valid date in the future!");
                            return ;
                          }
                          setPlaneData({...planeData, NgayXuatPhat : e.target.value});
                        }
                      }
                      value = {planeData.NgayXuatPhat}
                      onFocus={(e) => (e.currentTarget.type = "date")}
                      onBlur={(e) => (e.currentTarget.type = "text")}
                    />
                  </div>
                  <div className="flex border rounded bg-gray-100 items-center p-2 ">
                    <input type="radio" className="bg-gray-100 max-w-full focus:outline-none text-gray-700" checked="checked"/>
                    <span className="ml-2">Find the cheapest</span>
                  </div>
                </div>
              </div>
              <div className="flex justify-center"><button className="p-2 border w-1/4 rounded-md bg-gray-800 text-white"
                onClick={handleFindPlane}
              >Search</button></div>
            </div>
          </div>
        </div>
      );
}