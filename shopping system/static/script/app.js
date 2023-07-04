var cart = [];

// 获取产品列表
axios.get('/api/products')
  .then(function (response) {
    var products = response.data;

    // 渲染产品列表
    var productHtml = '';
    for (var i = 0; i < products.length; i++) {
      var product = products[i];
      productHtml += '<tr>';
      productHtml += '<td>' + product.name + '</td>';
      productHtml += '<td>' + product.price + '</td>';
      productHtml += '<td>' + product.description + '</td>';
      productHtml += '<td><button data-id="' + product.id + '" class="add-to-cart">加入购物车</button> <button data-id="' + product.id + '" class="remove-from-cart">移除购物车</button></td>';
      productHtml += '</tr>';
    }
    document.querySelector('#product-list').innerHTML = productHtml;

    // 添加加入购物车按钮的点击事件监听器
    var addToCartButtons = document.querySelectorAll('.add-to-cart');
    for (var i = 0; i < addToCartButtons.length; i++) {
      addToCartButtons[i].addEventListener('click', addToCart);
    }

    // 添加移除购物车按钮的点击事件监听器
    var removeFromCartButtons = document.querySelectorAll('.remove-from-cart');
    for (var i = 0; i < removeFromCartButtons.length; i++) {
      removeFromCartButtons[i].addEventListener('click', removeFromCart);
    }
  })
  .catch(function (error) {
    console.log(error);
  });

// 加入购物车
function addToCart(event) {
  var productId = event.target.dataset.id;

  axios.post('/api/cart', {productId: productId})
    .then(function (response) {
      alert('添加成功！');
      var item = response.data;
      var index = findCartItemIndex(item.productId);
      if (index !== -1) {
        // 更新购物车中的产品数量和总价
        cart[index].quantity++;
        cart[index].totalPrice = cart[index].quantity * cart[index].price;
      } else {
        // 将产品添加到购物车中
        cart.push({
          productId: item.productId,
          name: item.name,
          price: item.price,
          quantity: 1,
          totalPrice: item.price
        });
      }
      renderCart();
    })
    .catch(function (error) {
      console.log(error);
    });
}

// 移除购物车
function removeFromCart(event) {
  var productId = event.target.dataset.id;

  axios.delete('/api/cart/' + productId)
    .then(function (response) {
      alert('移除成功！');
      var item = response.data;
      var index = findCartItemIndex(item.productId);
      if (index !== -1) {
        // 更新购物车中的产品数量和总价
        cart[index].quantity--;
        cart[index].totalPrice = cart[index].quantity * cart[index].price;
        if (cart[index].quantity === 0) {
          cart.splice(index, 1);
        }
      }
      renderCart();
    })
    .catch(function (error) {
      console.log(error);
    });
}



// 移除购物车
function removeFromCart(event) {
var productId = event.target.dataset.id;

axios.delete('/api/cart/' + productId)
.then(function (response) {
alert('移除成功！');
var item = response.data;
var index = findCartItemIndex(item.productId);
if (index !== -1) {
// 如果购物车中的产品数量为1，则将该产品从购物车中移除
if (cart[index].quantity === 1) {
cart.splice(index, 1);
} else {
// 更新购物车中的产品数量和总价
cart[index].quantity--;
cart[index].totalPrice = cart[index].quantity * cart[index].price;
}
renderCart();
}
})
.catch(function (error) {
console.log(error);
});
}

// 渲染购物车
function renderCart() {
// 渲染购物车列表
var cartHtml = '';
for (var i = 0; i < cart.length; i++) {
var item = cart[i];
cartHtml += '<tr>';
cartHtml += '<td>' + item.name + '</td>';
cartHtml += '<td>' + item.price + '</td>';
cartHtml += '<td>' + item.quantity + '</td>';
cartHtml += '<td>' + item.totalPrice + '</td>';
cartHtml += '</tr>';
}
document.querySelector('#cart-list').innerHTML = cartHtml;

// 渲染购物车总价
var totalHtml = '总价：';
var totalPrice = 0;
for (var i = 0; i < cart.length; i++) {
totalPrice += cart[i].totalPrice;
}
totalHtml += totalPrice;
document.querySelector('#total-price').innerHTML = totalHtml;
}

// 查找购物车中的产品索引
function findCartItemIndex(productId) {
for (var i = 0; i < cart.length; i++) {
if (cart[i].productId === productId) {
return i;
}
}
return -1;
}