document.addEventListener('DOMContentLoaded', function() {
  const decreaseButtons = document.querySelectorAll('.decrease-quantity');
  const increaseButtons = document.querySelectorAll('.increase-quantity');

  decreaseButtons.forEach(button => {
    button.addEventListener('click', function() {
      const quantitySpan = this.nextElementSibling;
      let quantity = parseInt(quantitySpan.textContent);
      if (quantity > 1) {
        quantity--;
        quantitySpan.textContent = quantity;
        updateQuantity(this.closest('.cart-item'), quantity);
        if (quantity === 1) {
          this.disabled = true;
        }
      }
    });
  });

  increaseButtons.forEach(button => {
    button.addEventListener('click', function() {
      const quantitySpan = this.previousElementSibling;
      let quantity = parseInt(quantitySpan.textContent);
      if (isNaN(quantity)) {
        console.error('Quantity is not a number');
        return;
      }
      quantity++;
      quantitySpan.textContent = quantity;
      updateQuantity(this.closest('.cart-item'), quantity);
      this.previousElementSibling.previousElementSibling.disabled = false;
    });
  });
  function updateQuantity(cartItem, quantity) {
    const itemId = cartItem.querySelector('.quantity-box').dataset.itemId;
    console.log('itemId:', itemId);
  
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const url = `/carts/items/${itemId}`;
    console.log('URL:', url);
  
    fetch(url, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ quantity: quantity })
    }).then(response => {
      if (!response.ok) {
        throw new Error(`Network response was not ok, status: ${response.status}`);
      }
      return response.json();
    }).then(data => {
      console.log('Success:', data);
      updatePrice(cartItem, quantity); // update the price here
    }).catch(error => {
      console.error('Error:', error);
    });
  }
  

  function updatePrice(cartItem, quantity) {
    const price = parseFloat(cartItem.dataset.price);
    const totalPrice = price * quantity;
    const priceSpan = cartItem.querySelector('.price');
    priceSpan.textContent = totalPrice;
  }


});
