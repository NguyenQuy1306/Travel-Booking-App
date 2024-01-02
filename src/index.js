const cors = require('cors')
const express = require('express')
const jwt = require('jsonwebtoken')
var DB = require('./config/Dboperation')
const app = express()
const authToken = require('./AuthenticateToken')
const port = 5000


app.use(express.urlencoded({ extended: true }))
app.use(express.json())
app.use(cors())


////////////////API////////////////


app.post('/profile', authToken, async (req, res) => {
    try {
        console.log(req.data)
        const { userId } = req.data
        console.log(userId)
        const profile = await DB.getProfile(userId)
        res.status(200).send(profile)
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/bankAccount', authToken, async (req, res) => {
    try {
        const { userId } = req.data
        const bankAccount = await DB.getBankAccount(userId)
        res.status(200).send(bankAccount)
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/getOrder', authToken, async (req, res) => {
    try {
        const { userId } = req.data
        const order = await DB.getOrder(userId)
        res.status(200).send(order)
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/getTicketOfOrder', authToken, async (req, res) => {
    try {
        const { MaDonHang } = req.body
        const orderId = MaDonHang
        const ticket = await DB.getTicketOfOrder(orderId)
        res.status(200).send(ticket)
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/getPassengerOfTicket', authToken, async (req, res) => {
    try {
        const { MaDatVe } = req.body
        const ticketId = MaDatVe
        const passenger = await DB.getPassengerOfTicket(ticketId)
        res.status(200).send(passenger)
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})



/*
return: {
    success: Bool
    token 
}thoi
*/
app.post('/login', async (req, res) => {
    try {
        const { username, password, role } = req.body
        const secretKey = 'alo1234'
        const users = await DB.getAccount(username, role)
        if (users[0] && users[0].MatKhau === password) {

            const token = jwt.sign(
                {
                    userId: users[0].MaSo,
                    username: users[0].TenDangNhap,
                    userRole: role
                },
                secretKey,
                { expiresIn: "12h" }
            )

            res.status(200).send({ success: true, token: token })
        }
        else res.status(401).send({ success: false })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})



/*
return: {
    flights: [
        {
            MaSoMayBay: 'CB001',
            LoaiKhoang: 'Economy',
            GiaKhoang: 800000,
            MoTa: 'Standard seating with in-flight entertainment',
            SoLuongGheToiDaCungCap: 150,
            SoLuongGheConLai: 149
        }
    ]
}
*/
app.post('/flight', authToken, async (req, res) => {

    try {
        const { startDate, deptLoc, destLoc, quantity } = req.body
        const flights = await DB.getFlight(startDate, deptLoc, destLoc, quantity)
        // const flights = await DB.getFlight('2023-03-01', 'HaNoi', 'Ho Chi Minh City', 19)
        console.log(flights)
        res.status(200).send({ flights: flights })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})


/*
return: {
    success
}
*/
app.post('/passenger/insert', authToken, async (req, res) => {
    try {
        const passenger = req.body;
        const resultFromDB = await DB.insertPassenger(
            passenger.name,
            passenger.phonenumber,
            passenger.email,
            passenger.CCCD,
            passenger.birthday,
            passenger.ticketId,
            passenger.flightId,
            passenger.cabinType
        );
        console.log(resultFromDB)
        res.status(200).send({ success: true, data: resultFromDB });
    } catch (err) {
        console.error(err);
        res.status(500).send({ success: false, message: err.message });
    }
});


app.post('/luggage/insert', authToken, async (req, res) => {
    try {
        const luggage = req.body
        const resultFromDB = await DB.insertLuggage(
            luggage.MaSoMayBay,
            luggage.LoaiHanhLyKyGui,
            luggage.MaNguoiThamGiaChuyenBay,
            luggage.SoLuong
        );
        res.status(200).send({ success: true });
    }
    catch (err) {
        console.error(err);
        res.status(500).send({ message: err.message });
    }
})

/*
return: {
    success
}
*/
app.post('/passenger', async (req, res) => {
    try {
        const { ticketId } = req.body
        passenger = await DB.getPassenger(ticketId)
        res.status(200).send({ success: true })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

/*
return: {
    success
}
*/
// app.post('/passenger/update', async (req, res) => {
//     try {
//         const { ticketId, passengers } = req.body
//         await DB.deletePassenger(ticketId)
//         for (let passenger of passengers) {
//             await DB.insertPassenger(passenger.name,
//                 passenger.phonenumber,
//                 passenger.email,
//                 passenger.CCCD,
//                 passenger.birthday,
//                 ticketId,
//                 passenger.flightId,
//                 passenger.cabinType
//             )
//         }
//         res.status(200).send({ success: true })
//     }
//     catch (err) {
//         res.status(500).send({ message: err.message })
//     }
// })

app.post('/passenger/update', authToken, async (req, res) => {
    try {
        const passenger = req.body
        await DB.updatePassenger(
            passenger.ID,
            passenger.name,
            passenger.phonenumber,
            passenger.email,
            passenger.CCCD,
            passenger.birthday,
            passenger.ticketId,
            passenger.flightId,
            passenger.cabinType
        )
        res.status(200).send({ success: true })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/passenger/delete', authToken, async (req, res) => {
    try {
        const { ID } = req.body
        console.log(ID)
        await DB.deletePassenger(ID)
        res.status(200).send({ success: true })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})


/*
return: {
    ticketId
}
*/
app.post('/flightTicket/generate', authToken, async (req, res) => {
    try {

        const flightId = req.body.flightID
        const orderId = req.body.orderId
        const ticket = await DB.generateFlightTicket(flightId, orderId)
        res.status(200).send({ ticketId: ticket[0]['Column0'] })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})


/*
return: {
    orderId
}
*/
app.post('/order/generate', authToken, async (req, res) => {

    try {
        const customerId = req.data.userId
        const order = await DB.generateOrder(customerId)
        res.status(200).send({ orderId: order[0]['Column0'] })
    }
    catch (err) {
        []
        res.status(500).send({ message: err.message })
    }
})

/*
return: {
    rooms: [
        {
            MaSoThueKhachSan: 'KS002',
            TenKhachSan: 'Budget Inn1',
            DiaChi: '456 Side Street',
            ThanhPho: 'City B',
            LoaiPhong: 'Couple',
            MoTa: 'Compact room for solo travelers',
            GiaPhong: 300000,
            SoLuongCungCap: 10
        }
    ]
}
*/
app.post('/room', authToken, async (req, res) => {
    try {
        const { checkInDate, checkOutDate, city } = req.body
        const rooms = await DB.getRoom(checkInDate, checkOutDate, city)
        // const rooms = await DB.getRoom('2023-03-01', '2023-03-02', 'City B')
        // console.log(rooms)
        res.status(200).send({ rooms: rooms })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})


/*
return: {
    ticketId
}
*/
// app.post('/roomTicket/generate', async (req, res) => {
//     try {
//         const { orderId } = req.body
//         const ticket = await DB.generateRoomTicket(orderId)
//         res.status(200).send({ ticketId: ticket[0]['Column0'] })
//     }
//     catch (err) {
//         res.status(500).send({ message: err.message })
//     }
// })

/*
return:{
    revenue: [
        {
            Thang,
            TongDoanhThuThang
        }
    ]
}
*/
app.post('/revenue', authToken,async (req, res) => {
    try {
        const {airline, year } = req.body
        const userId  = req.data.userId
        const revenue = await DB.getRevenue(userId, airline, year)
        // const revenue = await DB.getRevenue('TK003', 'AirAsia', '2023')
        res.status(200).send({ revenue: revenue })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})


/*
return: {
    numberPassenger: [
        {
            TenHang: 'AirAsia',
            MaSoChuyenBay: 'CB002',
            LoaiKhoang: 'Business',
            SoLuongNguoiThamGia: 0,
            TongTienVeThuDuoc: 0
        }
    ]
}
*/
app.post('/numberPassenger', authToken, async (req, res) => {
    try {
        const { date } = req.body
        const userId = req.data.userId
        const numberPassenger = await DB.getNumberPassenger(userId, date)
        // const numberPassenger = await DB.getNumberPassenger('TK003', '2023 -03-02')
        // console.log(numberPassenger)
        res.status(200).send({ numberPassenger: numberPassenger })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})
app.post('/numberPassengerOfAirline', authToken, async (req, res) => {
    try {
        const { airline, date } = req.body
        const userId  = req.data.userId
        const numberPassenger = await DB.getNumberPassengerOfAirline(userId, airline, date)
        res.status(200).send({ numberPassenger: numberPassenger })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/numberPassengerTotal', authToken, async (req, res) => {
    try {
        const userId  = req.data.userId
        const numberPassenger = await DB.getNumberPassengerTotal(userId)
        res.status(200).send({ numberPassenger: numberPassenger })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/getFlightService',authToken, async (req, res) => {
    try {
        const { userId } = req.data
        const flightService = await DB.getFlightService(userId)
        res.status(200).send({ flightService: flightService })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})
app.post('/getHotelService',authToken, async (req, res) => {
    try {
        const { userId } = req.data
        const hotelService = await DB.getHotelService(userId)
        res.status(200).send({ hotelService: hotelService })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/getCabinFlight',authToken, async (req, res) => {
    try {
        const { userId, MaSoMayBay } = req.data
        const cabinFlight = await DB.getCabinFlight(userId)
        res.status(200).send({ cabinFlight: cabinFlight })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.post('/getLuggage', authToken, async (req, res) => {
    try {
        const { MaSoMayBay } = req.body
        const luggage = await DB.getLuggage(MaSoMayBay)
        res.status(200).send({ luggage: luggage })
    }
    catch (err) {
        res.status(500).send({ message: err.message })
    }
})

app.listen(port, () => {
    console.log(`App listening on port ${port}`)
})