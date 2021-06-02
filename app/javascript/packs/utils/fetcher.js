// Fetch Helper
export default function newRequest(URL){
  //New Promise recibe una funcion
  return new Promise((resolve, reject)=> {
    const req = new XMLHttpRequest();
    req.onreadystatechange = (e) => {
      if (req.readyState === 4) {
        if(req.status === 200){
          resolve(JSON.parse(req.responseText))
        } else {
          console.error("Error on fetch:", req.onerror)
          reject(new Error(`Se produjo un error: ${req.status}`))
        }
      }
    }
    req.open('GET', URL);
    req.send(null);
  })
}