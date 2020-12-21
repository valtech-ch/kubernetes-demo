import React, {useState, useEffect} from 'react'


export default function Home() {
const [loaded, setLoaded] = useState(false)
const [data, setData] = useState(null)
const [error, setError] = useState(null)
const backendBaseURL = process.env.REACT_APP_BACKEND_BASE_URL

    useEffect(() => {
        fetch(`${backendBaseURL}/api`)
        .then((res) => res.text())
        .then((result) => {
            setLoaded(true)
            setData(result)
        }, (error) => {
            setLoaded(true)
            setError(error)
        })
    }, [backendBaseURL])

    if (error) {
        return (
            <div>
                <h3>Kubernetes Demo Application</h3>
                <p>Error: {error.message}</p>
            </div>
        )
    } else if (!loaded) {
        return (
            <div>
                <h3>Kubernetes Demo Application</h3>
                <p>Loading...</p>
            </div>
        )
    } 

    return (
        <div>
            <h3>Kubernetes Demo Application</h3>
            <div>
                {data}
            </div>
        </div>
    )
}