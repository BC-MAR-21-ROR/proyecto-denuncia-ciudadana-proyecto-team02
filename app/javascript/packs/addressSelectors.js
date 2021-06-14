class SelectAddress {
  currentSelectors = [];
  inputsIds = [
    "denounce_address_attributes_state",
    "denounce_address_attributes_municipality",
    "denounce_address_attributes_settlement",
    "postalCodeInput",
  ];
  currentSettlements = [];

  constructor() {
    this.build();
  }

  build() {
    for (const inputId of this.inputsIds) {
      const generatedInput = document.querySelector(`#${inputId}`);
      this.currentSelectors.push(generatedInput);
    }
    console.info("Done generating selectors, all good");
    if (!this.currentSelectors[1].value) this.resetDataAndDisables(0, true)
  }

  start() {
    if (this.currentSelectors.length > 0) {
      for (const [index, selector] of this.currentSelectors.entries()) {
        if (index >= 3) continue; //we dont need a event on postalCode
        selector.addEventListener("change", (event) => {
          const value = event.target.value || selector.value;
          if (index === 2) {
            const filteredSettlement = this.currentSettlements.find(settlementCache => settlementCache.name === value);
            this.currentSelectors[3].value = filteredSettlement.postal_code //simulate function to change postal code
          } else {
            const url =
              index === 0 //si el es selector de states/
                ? `/api/municipalities?state=${value}`
                : `/api/settlements?municipality=${value}`;
            this.selectorControllerRequest(url, index);
          }

          this.resetDataAndDisables(index);
        });
      }
      console.info("Applied Events with success!");
    } else {
      throw new Error("We need valid selectors id's to start.");
    }
  }

  resetDataAndDisables(selectedIndex, isInitialSetup = false) {
    let currentIndexToInspect = this.currentSelectors.length - 1
    while (currentIndexToInspect >= 0) {
      if (selectedIndex === currentIndexToInspect || (currentIndexToInspect === selectedIndex + 1 && !isInitialSetup)) {
        this.currentSelectors[currentIndexToInspecast].disabled = false 
        return
      }
      this.currentSelectors[currentIndexToInspect].value = "";
      this.currentSelectors[currentIndexToInspect].disabled = true
      currentIndexToInspect--;
    }
  }

  async selectorControllerRequest(url, selectPostion) {
    this.currentSelectors[selectPostion + 1].innerHTML = "";
    const dataFromApi = await newRequest(url);

    let optionIncludeBlank = document.createElement("option");
    this.currentSelectors[selectPostion + 1].add(optionIncludeBlank);

     if (selectPostion === 1) this.currentSettlements = []
    for (const data of dataFromApi) {
      const option = document.createElement("option");

      option.text = data.name;
      this.currentSelectors[selectPostion + 1].add(option);
      if (selectPostion === 1) this.currentSettlements.push(data);
    }
  }
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
  try {
    const script = new SelectAddress()
    script.start()
  }
  catch( e ) {
    console.error("Error loading script...", e)
  }
}
