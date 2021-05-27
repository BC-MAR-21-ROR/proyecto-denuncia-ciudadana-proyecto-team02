function init() {
  const statesSelector = document.querySelector("#denounce_address_attributes_state");
  const municipalitySelector = document.querySelector("#denounce_address_attributes_municipality");
  const settlementSelector = document.querySelector("#denounce_address_attributes_settlement");
  const postalCodeInput = document.querySelector("#postalCodeInput");

  console.info("Municipality Selector", municipalitySelector)
  let toggle = false;
  if (!municipalitySelector.value) toggle = true
  municipalitySelector.disabled = toggle;
  settlementSelector.disabled = toggle;
  postalCodeInput.disabled = toggle;

    // caching
    let currentSettlements = [];

    statesSelector.addEventListener('change', async function (event) {
      let value = event.target.value || statesSelector.nodeValue
      municipalitySelector.innerHTML = ""
      const municipalities = await newRequest(`/api/municipalities?state=${value}`)
      console.info("Selected municipallies:", municipalities);
      let optionIncludeBlank = document.createElement("option");
      municipalitySelector.add(optionIncludeBlank);
      for (const municipality of municipalities) {
        const option = document.createElement("option");

        option.text = municipality.name;
        municipalitySelector.add(option)
      }

      //disable to reset data
      settlementSelector.value = "Choose one"
      postalCodeInput.value = ""
      settlementSelector.disabled = true
      postalCodeInput.disabled = true;
      municipalitySelector.disabled = false
    })

    municipalitySelector.addEventListener('change', async function (event) {
      // debugger

      let value = event.target.value || municipalitySelector.nodeValue
      settlementSelector.innerHTML = ""
      const settlements = await newRequest(`/api/settlements?municipality=${value}`)
      console.info("Selected settlements:", settlements);

      currentSettlements = [];
      let optionIncludeBlank = document.createElement("option");
      settlementSelector.add(optionIncludeBlank);

      for (const settlement of settlements) {
        const option = document.createElement("option");
        // option.name = settlement.name;
        option.text = settlement.name;
        settlementSelector.add(option);
        currentSettlements.push(settlement);

      }
      postalCodeInput.disabled = false;
      postalCodeInput.value = ""
      settlementSelector.disabled = false;
    })

    settlementSelector.addEventListener('change', function (event) {
      let value = event.target.value || settlementSelector.nodeValue
      const filteredSettlement = currentSettlements.find(settlementCache => settlementCache.name === value);

      postalCodeInput.value = filteredSettlement.postal_code
      postalCodeInput.disabled = false;
    })
}

// Fetch Helper
function newRequest(URL){
  //New Promise recibe una funcion
  return new Promise((resolve, reject)=> {
    const req = new XMLHttpRequest();
    req.onreadystatechange = (e) => {
      if (req.readyState === 4) {
        if(req.status === 200){
          resolve(JSON.parse(req.responseText))
        } else {
          reject(new Error(`Se produjo un error: ${req.status}`))
        }
      }
    }
    req.open('GET', URL);
    req.send(null);
  })
}

window.onload = function () {
    init()
}
