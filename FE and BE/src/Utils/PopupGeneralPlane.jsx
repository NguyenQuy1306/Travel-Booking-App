import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";  
import Table from "./Table";
import axios from "axios";
import Cookies from "universal-cookie";

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
    Header: "number of passenger",
    accessor: "SoLuongNguoiThamGia",
  },
  {
    Header: "Date",
    accessor: "Ngay",
  },
  {
    Header: "Total Revenue",
    accessor: "TongTienVeThuDuoc",
  }
]
export default function GeneralPlane({visible, onClose}){
  const cookie = new Cookies();
  const [total, setTotal] = useState(0);
  const navigate = useNavigate();
  const [date, setDate] = useState("");
  const [ticket, setTicket] = useState([]);
  const handleDate = (e) => {
    if (date === "") {
      alert("Please enter a valid date");
      return;
    }
    const now = new Date();
    const dateArr = date.split("-");
    const dateStr = dateArr[0] + "-" + dateArr[1] + "-" + dateArr[2];
    console.log(dateStr);
    axios.post("http://localhost:5000/numberPassenger", { token: cookie.get("token"), date: dateStr }).then((res) => {
      console.log(res.data);
      const temp = res.data.numberPassenger;
      let tempTotal = 0
      for(let i = 0; i < temp.length; i++){
        tempTotal += temp[i].TongTienVeThuDuoc;
        temp[i]["Ngay"] = dateStr;
        temp[i].TongTienVeThuDuoc = new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(temp[i].TongTienVeThuDuoc);
      }
      tempTotal = new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(tempTotal);
      setTotal(tempTotal);
      setTicket(temp);
    }
    ).catch((err) => {
      console.log(err);
    });
  }
  const handleTotal = (e) => {
    axios.post("http://localhost:5000/numberPassengerTotal", { token: cookie.get("token") }).then((res) => {
      console.log(res.data);
      const temp = res.data.numberPassenger;
      let tempTotal = 0
      for(let i = 0; i < temp.length; i++){
        tempTotal += temp[i].TongTienVeThuDuoc;
        temp[i].TongTienVeThuDuoc = new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(temp[i].TongTienVeThuDuoc);
      }
      tempTotal = new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'VND' }).format(tempTotal);
      setTotal(tempTotal);
      setTicket(temp);
    }
    ).catch((err) => {
      console.log(err);
    });
  }
  const handleOnClose = () => {
    onClose();
  }
  
  if (!visible) return null;
  return (
    <section className="flex justify-center place-content-center place-self-center">
      <div 
    className="fixed inset-0 bg-black bg-opacity-20 backdrop-blur-sm flex justify-center items-center">
      <div className="mb-14 md:mb-0   bg-white rounded-3xl ">
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
          <div className="text-center font-semibold font-serif text-3xl">
            General Statistics 
          </div>
          {/* <!-- Header --> */}
          <div className="px-10 py-3">
              <div className="font-serif"><button onClick={handleTotal} className="text-teal-500 hover:text-teal-700 font-bold">See your total in all time</button>
              <div className="font-serif">Your planes on date: 
                  <input type="date" 
                  onChange={(e) => setDate(e.target.value)}
                  value={date}
                  className="border border-gray-300 rounded-md p-1 ml-5 my-3" placeholder="Search" />
                  <button onClick={handleDate}
                  className="bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded ml-5">Search</button>
                  <span className="px-5"> Total Revenue: {total} </span>
              </div>
              </div>
              <div className="py-5">
                <Table columns={columnsFlight} data={ticket} />
              </div>
          </div>
          
        </div>
      </div>
    </div>
    </section>
  ) 
}
