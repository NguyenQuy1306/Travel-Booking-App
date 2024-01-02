import React, { useState } from "react";
import { TERipple } from "tw-elements-react";
import { useNavigate } from "react-router-dom";  
import axios from "axios";
import Cookie from "universal-cookie";

export default function LoginForm({visible, onClose}){
  const cookie = new Cookie();
  const [role, setRole] = useState("user"); // ["user", "provider"]
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();
  const handleOnClose = () => {
    onClose();
  }
  const handleSubmit = () =>{
    const data = {
      username : username,
      password : password,
      role : role
    }
    console.log(data)
    
    axios.post("http://localhost:5000/login", data)
    .then((res) => {
      console.log(res.data)
      if (data.role === "user"){
        navigate("/user")
      }
      else{
        navigate("/provider")
      }
      cookie.set("token", res.data.token, {path: "/"})
      cookie.set("role", data.role, {path: "/"})
    })
    .catch((err) => {
      console.log(err)
      alert("Username not found or password is incorrect")
    })
  }
  if (!visible) return null;
  return (
    <div 
    className="fixed inset-0 bg-black bg-opacity-20 backdrop-blur-sm flex justify-center items-center">
      <div className="mb-14 md:mb-0 md:w-8/12 lg:w-5/12 xl:w-5/12 bg-white rounded-3xl ">
      <form>

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
              
              {/* <!--Sign in section--> */}
              <div className="flex flex-row items-center justify-center lg:justify-star sticky p-2">
                <p className="mb-0 mr-4 text-lg">Sign in with</p>

                {/* <!-- Facebook button--> */}
                <TERipple rippleColor="light">
                  <button
                    type="button"
                    className="bg-blue-600 mx-1 h-9 w-9 rounded-full bg-primary uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"
                  >
                    {/* <!-- Facebook --> */}
                    <img src="/facebook.svg"
                      className="mx-auto h-5 w-5"
                    />
                  </button>
                </TERipple>

                {/* <!-- Twitter button --> */}
                <TERipple rippleColor="light">
                  <button
                    type="button"
                    className="bg-blue-600 mx-1 h-9 w-9 rounded-full bg-primary uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"
                  >
                    {/* <!-- Twitter --> */}
                    <img src="/twitter.svg"
                      className="mx-auto h-5 w-5"
                    />
                  </button>
                </TERipple>

                {/* <!-- Linkedin button --> */}
                <TERipple rippleColor="light">
                  <button
                    type="button"
                    className="bg-blue-600 mx-1 h-9 w-9 rounded-full bg-primary uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]"
                  >
                    {/* <!-- Linkedin --> */}
                    <img src="/linkedin.svg"
                      className="mx-auto h-5 w-5"
                    />
                  </button>
                </TERipple>
              </div>

              {/* <!-- Separator between social media sign in and email/password and role user,provider sign in --> */}
              <div className="stickymy-4 flex items-center before:mt-0.5 before:flex-1 before:border-t before:border-neutral-300 after:mt-0.5 after:flex-1 after:border-t after:border-neutral-300">
                <p className="mx-4 mb-0 text-center font-semibold dark:text-white">
                  Or
                </p>
              </div>
              <div className="LoginForm p-5">
                <div>
                  Username
                  <input type="text" 
                  onChange={(e) => {
                    setUsername(e.target.value)
                  }
                  }
                  placeholder="Email" className="border-2 border-gray-300 rounded-md p-2 w-full my-3"/>
                </div>
                <div>
                  Password
                  <input type="password" 
                  onChange={(e) => {
                    setPassword(e.target.value)}
                  }
                  placeholder="Password" className="border-2 border-gray-300 rounded-md p-2 w-full my-3" />
                </div>
                <div>
                  Role
                  <select 
                    onChange={
                      (e) => {
                        setRole(e.target.value)
                      }
                    }
                  className="border-2 border-gray-300 rounded-md p-2 w-full my-3">
                    <option value="user">User</option>
                    <option value="provider">Provider</option>
                  </select>
                </div>
              </div>


              {/* <!-- Remember me and forgot password section --> */}
              <div className="flex flex-row items-center justify-between px-6">
                <div className="flex items-center">
                  <input
                    type="checkbox"
                    className="h-4 w-4 rounded-sm border-gray-300 mr-2"
                  />
                  <p className="text-sm hover:text-gray-500">Remember me</p>
                </div>
                <button type="button" className="text-sm hover:text-blue-500">Forgot password?</button>
              </div>

              {/* <!-- Sign in button --> */}
              <div className="flex justify-center">
                <button
                  type="button"
                  onClick={
                    ()=>handleSubmit()
                  }
                  className="bg-gray-400 text-white font-semibold px-3 py-1 text-xl my-7 rounded-3xl hover:bg-gray-300"
                >
                  {/* <!-- Sign in --> */}
                  Login
                </button>
              {/* X close */}
              </div>

            </form>
      </div>
    </div>
  )
}
