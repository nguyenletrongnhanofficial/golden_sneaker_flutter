# GOLDEN SNEAKER - NGUYEN LE TRONG NHAN

This is an app with a beautiful interface and lively animation, allowing you to order shoes quickly and easily.

![goldensneaker](https://github.com/nguyenletrongnhanofficial/golden_sneaker_flutter/assets/108941086/6048e56a-1f07-4329-8c2f-ec56095bf705)


[Live Demo](https://goldensneaker.vercel.app/)

## Completed Requirements

- Display all products in `Our Products` section:
  - Single product should have name, description, price, image and `Add To Cart` button.
  - User able to click on `Add To Cart` to add target product to their cart.
  - Added product doesn't have `Add To Cart` button anymore, it should have `Check Mark Icon (✓)` instead.
- Display all added products in `Your Cart` section:
  - Each product in cart should have name, price, image, increase/decrease amount button and remove button.
  - User able to increase/decrease amount of a product in cart. When product's amount is decreased to zero, that product will be removed from cart naturally.
  - User able to remove product from cart.
  - Show total price of all products in car. When user increase/decrease product's amount or remove product, total price should be re-calculate correctly.
  - When there are no products in cart, we should show `Your cart is empty` message.
  - Products in cart should be persistent: When user visit the application, products are added before should be showed, user don't need to add products again.
- I have executed Responsive design effectively.
- And I have also implemented smooth animation effects.
- Regarding the requirement to deploy the application to Heroku, due to Heroku no longer offering free hosting, I have deployed it to [Vercel](https://goldensneaker.vercel.app) instead, with the following URL: 
```bash
https://goldensneaker.vercel.app
```
- For the Products data, since Heroku no longer provides free usage, I have deployed it to [render.com](https://golden-sneaker-apis.onrender.com/shoes), with the following URL:
```bash
https://golden-sneaker-apis.onrender.com/shoes
```
- And here is the source code of my Products data APIs written in [Node.js](https://github.com/nguyenletrongnhanofficial/golden_sneaker_apis):
```bash
https://github.com/nguyenletrongnhanofficial/golden_sneaker_apis
```
- Hmm... with render.com, if it's not used for a while, it will temporarily go offline until it's used again. So, I coded it in a way that if the program doesn't receive product data within 50 microseconds, it will retrieve the data I have stored within the program. I hope you will like my solution😇.

## Author

[Nguyen Le Trong Nhan](https://github.com/nguyenletrongnhanofficial)
