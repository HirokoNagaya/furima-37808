window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const taxInput = document.getElementById("add-tax-price");
  const profitInput = document.getElementById("profit");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = Math.floor(inputValue * 0.9);
 })
});