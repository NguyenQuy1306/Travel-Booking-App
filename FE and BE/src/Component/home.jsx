import React, {useState} from "react";
import LoginForm from "../Utils/PopupForm";

export default function Home() {
  const [showLoginForm, setShowLoginForm] = useState(false);
  const handleOnClose = () => setShowLoginForm(false);
  return (
    <section className="relative isolate overflow-hidden bg-gray-900 xl:h-screen">
        <img
          src="/hero-banner.jpg"
          alt=""
          // make backgorund grey color to transparent
          className="absolute inset-0 -z-10 h-full w-full object-cover object-right md:object-center opacity-50"
        />
        <nav className="p-12 ">
          <hr/>
          <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto py-5">
            <div class="flex items-center space-x-3 rtl:space-x-reverse">
                <button className="bg-gray-400 p-3 rounded-full hover:bg-transparent hover:bg-teal-400">
                  <img src="/phone.svg" class="h-8 rounded-full " alt="phone Logo" />
                </button>
                <div>
                  <span className="text-white">Contact :</span>
                  <br/>
                  <span class="self-center text-base font-semibold whitespace-nowrap text-white">
                    +01 (234) 567 89
                  </span>
                </div>
            </div>
            <hr/>
            <div class="hidden w-full md:block md:w-auto" id="navbar-default">
              <ul class="font-medium flex flex-col mt-4 border md:flex-row md:space-x-8 rtl:space-x-reverse md:mt-0 md:border-0 text-lg">
                <li>
                  <a href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">News</a>
                </li>
                <li>
                  <a href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Information</a>
                </li>
                <li>
                  <a href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Contact</a>
                </li>
                <li>
                  <a href="#" className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Register</a>
                </li>
                <li>
                  {/* <a href="#" class="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">Login</a> */}
                  <button onClick={() => setShowLoginForm(true)} className="block  text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 hover:text-teal-300 md:p-0 dark:text-white">
                    Login
                  </button>
                </li>
              </ul>
            </div>
          </div>
          <hr/>
        </nav>
        <div className="mx-auto px-auto pb-7">
          <div className="grid">
            <h2 className="text-4xl font-bold tracking-wider text-white sm:text-7xl place-content-center text-center font-serif ">TRAVEL LOOKING</h2>
            <p className="mt-6 text-lg leading-8 text-gray-300 text-center">
            Embark on a journey of discovery with <span className="text-xl font-bold font-serif">Travel Looking </span> 
            – your guide to <span className="text-xl font-bold font-serif">global exploration</span> and
            <span className="text-xl font-bold font-serif"> unforgettable adventures</span>
            </p>
          </div>
        </div>
        <div className="grid grid-cols-2 justify-between pt-5 pb-16 gap-20">
          <div className="bg-amber-100 md:w-92 md:h-fit rounded-2xl px-5 opacity-90 place-self-center p-3 shadow-2xl">
            {/* NEED Join of owner service like hotel,plane and restaurant */}
            <h1 className="font-bold text-center text-lg ">Welcome to TravelLooking <br/> Your gateway to business growth! </h1>

            <div className="text-4xl pt-5 text-center">Why Choose Us?</div>
            <div className="list-disc px-3 pt-3 text-lg text-center font-serif">
                <p>Easy Management: Streamlined operations.</p>
                <p>Reach More Customers: Showcase globally.</p>
                <p>Boost Bookings: Feature exclusive deals.</p>
            </div>
            <h2 className="text-center text-xl p-3">Let's grow together!</h2>
            <div className="flex justify-center font-semibold py-2">
              <button className="bg-gray-500 p-2 rounded-3xl text-white opacity-100 hover:bg-transparent hover:bg-gray-400 hover:text-gray-300">Contact us to Join</button>
            </div>
            <p className="p-3 text-center text-lg">Questions? Contact us at: <button className="font-bold hover:text-slate-500">ServiceTravelLook@email.com</button>.</p>
          </div>
          <div className="bg-teal-100 md:w-92 md:h-fit rounded-2xl px-5 opacity-90 place-self-center p-3 shadow-2xl">
            {/* NEED Join of owner service like hotel,plane and restaurant */}
            <h1 className="font-bold text-center text-lg ">Join Our Team at Travel Looking <br/> Unlock Your Future with Us </h1>

            <div className="text-4xl pt-5 text-center">Why Us?</div>
            <div className="list-disc px-3 pt-3 text-lg text-center font-serif">
                <p>Team Collaboration: Join a vibrant, collaborative team.</p>
                <p>Career Growth: Flourish in a dynamic work environment.</p>
                <p>Quick Application: Easy and quick online application process.</p>
            </div>
            <h2 className="text-center text-xl p-3">Ready to embark on a new journey?</h2>
            <div className="flex justify-center font-semibold py-2">
              <button className="bg-gray-500 p-2 rounded-3xl text-white opacity-100 hover:bg-transparent hover:bg-gray-400 hover:text-gray-300">Apply Now</button>
            </div>
            <p className="p-3 text-center text-lg ">Questions? Reach out us at: <button className="font-bold hover:text-slate-500">HiringTravelLook@email.com</button>.</p>
          </div>
          
        </div>
        <LoginForm onClose={handleOnClose} visible={showLoginForm}/>
    </section>

  )
}
  