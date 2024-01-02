import React from "react";
import { Navigate} from "react-router-dom";
import { useAuth } from "./useAuth";

export default function ProtectedRoute({children}) {
    const token = useAuth();
    if (token) {
       return children
    }
    return  <Navigate to="/" />;
}