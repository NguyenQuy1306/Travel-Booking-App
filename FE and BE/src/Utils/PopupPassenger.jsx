import React, { useEffect, useState, useRef } from "react";
import { useNavigate } from "react-router-dom";  


// const passenger = [
//   {
//     "name": "Nguyen Van A",
//     "phonenumber": "0123456789",
//     "email": "nva@email",
//     "CCCD": "123456789",
//     "birthday": "2000-01-01",
//     "cabinType": "Economy"
//   },
//   {
//     "name": "Nguyen Van B",
//     "phonenumber": "0123456789",
//     "email": "nvb@email",
//     "CCCD": "123456788",
//     "birthday": "2000-01-02",
//     "cabinType": "Economy"
//   },
//   {
//     "name": "Nguyen Van C",
//     "phonenumber": "0123456789",
//     "email": "nvc@email",
//     "CCCD": "123456787",
//     "birthday": "2000-01-03",
//     "cabinType": "Bussiness"
//   },
//   {
//     "name": "Nguyen Van D",
//     "phonenumber": "0123456789",
//     "email": "nvd@email",
//     "CCCD": "123456786",
//     "birthday": "2000-01-04",
//     "cabinType": "Bussiness"
//   },
//   {
//     "name": "Nguyen Van A",
//     "phonenumber": "0123456789",
//     "email": "nva@email",
//     "CCCD": "123456789",
//     "birthday": "2000-01-01",
//     "cabinType": "Economy"
//   },
//   {
//     "name": "Nguyen Van A",
//     "phonenumber": "0123456789",
//     "email": "nva@email",
//     "CCCD": "123456789",
//     "birthday": "2000-01-01",
//     "cabinType": "Economy"
//   },
//   {
//     "name": "Nguyen Van A",
//     "phonenumber": "0123456789",
//     "email": "nva@email",
//     "CCCD": "123456789",
//     "birthday": "2000-01-01",
//     "cabinType": "Economy"
//   },
//   {
//     "name": "Nguyen Van A",
//     "phonenumber": "0123456789",
//     "email": "nva@email",
//     "CCCD": "123456789",
//     "birthday": "2000-01-01",
//     "cabinType": "Economy"
//   },
//   {
//     "name": "Nguyen Van A",
//     "phonenumber": "0123456789",
//     "email": "nva@email",
//     "CCCD": "123456789",
//     "birthday": "2000-01-01",
//     "cabinType": "Economy"
//   },
  
// ]


export default function PassengerList({visible, onClose}){
    const [passenger, setPassenger] = useState([]);

    const [load, setLoad] = useState(false);
    const hasMounted = useRef(false);
    useEffect(() => {
      // load ticket from local storage
      if (localStorage.getItem("ticket") && localStorage.getItem("Ticket ID") !== null) {
        setPassenger(JSON.parse(localStorage.getItem("ticket"))[localStorage.getItem("Ticket ID")].passenger);
        setLoad(true);
      }
    })
    useEffect(() => {
      if(!hasMounted.current){
      if(localStorage.getItem("ticket") && localStorage.getItem("Ticket ID") !== null){
          setPassenger(JSON.parse(localStorage.getItem("ticket"))[localStorage.getItem("Ticket ID")].passenger);
          setLoad(true);
        }}
        else {
        hasMounted.current = true;
      }
    }, [load])
    const handleOnClose = () => {
        localStorage.removeItem("Ticket ID");
        onClose();
    }
    const handleOnSubmit = () => {
        localStorage.removeItem("Ticket ID");
        onClose();
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
            PASSENGERS LIST OF PLANE <span className="font-sans font-bold text-teal-400">{JSON.parse(localStorage.getItem("ticket"))[localStorage.getItem("Ticket ID")].flightID}</span>
          </div>
          <div className="text-center font-medium font-serif text-lg">
            Number of passengers: {passenger.length}
          </div>
          {/* <!-- Header --> */}
          <div className="flex justify-center  ">
            <table className="text-center m-10 ">
              <thead className="text-center">
                <tr>
                  <th className=" ">Full name</th>
                  <th className=" ">Phone number</th>
                  <th className=" ">Email</th>
                  <th className=" ">CID</th>
                  <th className=" ">Birthday</th>
                  <th className=" ">Cabin type</th>
                </tr>
              </thead>
              <tbody>
                {
                  passenger.map((item) => (
                    <tr>
                      <td className="border ">
                        <input type="text" 
                          onChange={
                            (e) => {
                              item.name = e.target.value;
                            }
                          }
                        value={(load)?item.name:null} className="border-0 bg-transparent text-center py-3"></input>
                      </td>
                      <td className="border ">
                        <input type="text" value={(load )?item.phonenumber:null} className="border-0 bg-transparent text-center py-3"></input>
                      </td>
                      <td className="border">
                        <input type="text" value={(load)?item.email:null} className="border-0 bg-transparent text-center py-3"></input>
                      </td>
                      <td className="border ">
                        <input type="text" value={(load)?item.CCCD:null} className="border-0 bg-transparent text-center py-3"></input>
                      </td>
                      <td className="border ">
                        <input type="text" value={(load)?item.birthday:null} className="border-0 bg-transparent text-center py-3"></input>
                      </td>
                      <td className="border">
                        <input type="text" value={(load)?item.cabinType:null} className="border-0 bg-transparent text-center py-3"></input>
                      </td>
                    </tr>
                  ))
                }
              </tbody>
            </table>
          </div>
     
        </div>
      </div>
    </div>
    </section>
  )
}
