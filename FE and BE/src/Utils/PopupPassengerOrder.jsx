import axios from "axios";
import React, { useEffect, useState, useRef } from "react";
import { act } from "react-dom/test-utils";
import { useNavigate } from "react-router-dom";  
import Cookies from "universal-cookie";

export default function PassengerListOrder({visible, onClose}){
    const cookie = new Cookies();
    const [passenger, setPassenger] = useState([]);
    const updatePassengerNth = (index, newData) => {
      setPassenger(prevState => {
        const updatedState = [...prevState];
        updatedState[index] = { ...updatedState[index], ...newData };
        return updatedState;
      });
    };
    const [active,setActive] = useState(false);
    const [load, setLoad] = useState(false);
    const [refresh, setRefresh] = useState(false);
    useEffect(() => {
      // load ticket from local storage
      if (localStorage.getItem("Ticket ID") !== null) {
        setLoad(true);
      }
    })
    useEffect(() => {
        if(localStorage.getItem("Ticket ID") !== null){
            (async () => {axios.post("http://localhost:5000/getPassengerOfTicket", { token: cookie.get("token"), MaDatVe: localStorage.getItem("Ticket ID") })
            .then((res) => {
              setPassenger(res.data);
              console.log(res.data);
            })
            .catch((err) => {
              console.log(err);
            })
          
          }
          )();
        }
    }, [refresh])
    const handleOnClose = () => {
        localStorage.removeItem("Ticket ID");
        onClose();
    }
    const handleOnSubmit = async () => {
        if(passenger.length === 0){
          localStorage.removeItem("Ticket ID");
          onClose();
          return ;
        }
        if (window.confirm("Are you sure with this information before edit?")) {
          for (let i = 0; i < passenger.length; i++) {
            if(passenger[i].HoVaTen === undefined || passenger[i].SoDienThoai === undefined || passenger[i].Email === undefined || passenger[i].SoCCCD === undefined || passenger[i].NgaySinh === undefined){
              alert("Please fill all the information for passenger " + i)
              return;
            }
            if (passenger[i].HoVaTen.match(/[^a-zA-Z ]/g)){
              alert("Please fill the correct name for passenger " + i)
              return ;
            }
            if(isNaN(passenger[i].SoDienThoai) || passenger[i].SoDienThoai.length < 7 || passenger[i].SoDienThoai.length > 11){
              alert("Please fill the correct phonenumber for passenger " + i)
              return ;
            }
            const checkEmail = passenger[i].Email.split('@')
            if(checkEmail.length !== 2){
              alert("Please fill the correct email for passenger " + i)
              return ;
            }
            // check leng = 12
            if(passenger[i].SoCCCD.length !== 12){
              alert("Please fill the correct CID for passenger " + i)
              return ;
            }
            // check age < 3
            let today = new Date();
            let birthDate = new Date(passenger[i].NgaySinh);
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
          const updatePassenger = async (data) => {
            try {
              const passengerResponse = await axios.post("http://localhost:5000/passenger/update", data);
              console.log(passengerResponse);
              console.log("Passenger updated");
            } catch (err) {
              console.error(err);
              console.log("Passenger not updated");
            }
          };
          for (let i = 0; i < passenger.length; i++) {
            try {
              const data = {
                token: cookie.get("token"),
                ID: passenger[i].MaKhachHang,
                name: passenger[i].HoVaTen,
                phonenumber: passenger[i].SoDienThoai,
                email: passenger[i].Email,
                CCCD: passenger[i].SoCCCD,
                birthday: passenger[i].NgaySinh,
                ticketId: passenger[i].MaVeMayBay,
                flightId: passenger[i].MaSoMayBay,
                cabinType: passenger[i].LoaiKhoang
              }
              await updatePassenger(data);
              console.log("Passenger updated");
            }
            catch (err) {
              console.error(err);
              console.log("Passenger not updated");
            }
          }
          localStorage.removeItem("Ticket ID");
          // onClose();
        }
    }
    const handleDelete = async (id) =>{
      if (window.confirm("Are you sure with this passenger, we are no longer to support you to buy again in this ticket?")) {
        const deletePassenger = async (data) => {
          try {
            const passengerResponse = await axios.post("http://localhost:5000/passenger/delete", data);
            console.log(passengerResponse);
            console.log("Passenger deleted");
            setRefresh(!refresh);
          } catch (err) {
            console.error(err);
            console.log("Passenger not deleted");
          }
        };
        try {
          const data = {
            token: cookie.get("token"),
            ID: passenger[id].MaKhachHang,
          }
          await deletePassenger(data);
          console.log("Passenger deleted");
        }
        catch (err) {
          console.error(err);
          console.log("Passenger not deleted");
        }
      }
    }
    const navigate = useNavigate();
  if (!visible) return null;

  return (
    <section className="flex justify-center place-content-center place-self-center">
      <div 
    className="fixed inset-0 bg-black bg-opacity-20 backdrop-blur-sm flex justify-center items-center">
      <div className="mb-14 md:mb-0 md:w-8/12 lg:w-5/12 xl:w-8/12 bg-white rounded-3xl ">
      <div>
          {/* <!-- Close button --> */}
          <div className="flex justify-between">
            <div></div>
            <div></div>
            <div>
              <button
                type="button"
                className=" font-semibold text-xl mx-3 mt-3  rounded-3xl hover:bg-gray-300 font-serif"
                onClick={handleOnClose}
              >
                {/* <!-- Close --> */}
                <img src="/close.svg" className="h-8" />
              </button>
            </div>
          </div>
          <div className="text-center font-semibold font-serif text-2xl">
            PASSENGERS LIST OF PLANE 
          </div>
          <div className="text-center font-medium font-serif text-lg">
            Number of passengers: {passenger.length}
          </div>
          <div className="flex justify-center pt-5">
            <button onClick={()=>{
              setActive(!active);
            }}> {(active === false)?<img src="/fix.svg" className="h-8"/>:<img src="/fix-active.svg" className="h-8"/>}
            </button>
          </div>
          {/* <!-- Header --> */}
          <div className="flex justify-center  ">
            <table className="text-center m-5 ">
              <thead className="text-center">
                <tr>
                  <th className=" ">ID</th>
                  <th className=" ">Full name</th>
                  <th className=" ">Email</th>
                  <th className=" ">ID card</th>
                  <th className=" ">Birthday</th>
                  <th className=" ">Phone number</th>
                </tr>
              </thead>
              <tbody>
                {
                  passenger.map((item,id) => (
                    <tr>
                      <td className="border px-2">{id}</td>
                      <td className="border ">
                        <input 
                        onChange={(e)=>{
                          updatePassengerNth(id, {HoVaTen: e.target.value});}
                        }
                        type="text"value={(load)?item.HoVaTen:null} disabled={!active} className="border-0 bg-transparent text-center py-3"
                        ></input>
                      </td>
                      <td className="border ">
                        <input type="text" value={(load )?item.Email:null} disabled={!active} className="border-0 bg-transparent text-center py-3"
                        onChange={(e)=>{
                          updatePassengerNth(id, {Email: e.target.value});}
                        }
                        ></input>
                      </td>
                      <td className="border ">
                        <input type="text" value={(load)?item.SoCCCD:null} disabled={!active} className="border-0 bg-transparent text-center py-3"
                        onChange={(e)=>{
                          updatePassengerNth(id, {SoCCCD: e.target.value});}
                        }
                        ></input>
                      </td>
                      <td className="border">
                        <input type="date" value={(load)?item.NgaySinh.split('T')[0]:null} disabled={!active} className="border-0 bg-transparent text-center py-3"
                        onChange={(e)=>{
                          updatePassengerNth(id, {NgaySinh: e.target.value});}
                        }
                        ></input>
                      </td>
                      <td className="border ">
                        <input type="text" value={(load)?item.SoDienThoai:null} disabled={!active} className="border-0 bg-transparent text-center py-3"
                        onChange={(e)=>{
                          updatePassengerNth(id, {SoDienThoai: e.target.value});}
                        } 
                        ></input>
                      </td>
                      <td className="p-2 ">
                        <button onClick={
                          () => handleDelete(id)
                        } disabled={!active}>{(active === false)?<img src="/trash.svg" className="h-8"/>:<img src="/trash-solid.svg" className="h-8"/>}</button>
                      </td>
                    </tr>
                  ))
                }
              </tbody>
            </table>
          </div>
          <div className="flex justify-center pb-5">
            <button
              onClick={handleOnSubmit}
            >
              <img src="/circle-check.svg" className="h-10" />
            </button>
          </div>
        </div>
      </div>
    </div>
    </section>
  )
}
