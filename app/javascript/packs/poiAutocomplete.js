import autoCompleteInput from "./utils/Autocomplete";
import newRequest from './utils/fetcher';

window.onload = (function () {
  // LINK https://www.w3schools.com/howto/howto_js_autocomplete.asp
  const postalCode = document.getElementById('postalCode');
  const settlementAutoComplete = document.getElementById('autoComplete')
  const currentSettlements = []
  postalCode.addEventListener("focusout", function (event) {
    const zipcode = event.target.value;
    if (zipcode && zipcode.length >= 5) {
      newRequest(`/api/settlements/${event.target.value}`)
        .then( response => {
          if (!response) throw new Error("There are not settlements for that postal code.");
          const settlements = response.map( settlement => settlement.name);
          autoCompleteInput(settlementAutoComplete, settlements)
          return settlements;
        })
        .catch( err => {
          //error handler for alerts.
          console.error("error", err)
          alert("Error happend");
        })
    }
  });
})()
