<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restaurant Home</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #1a1a1a; /* đen nền */
            color: #f5e6a1; /* vàng ánh kim nhẹ cho text */
        }

        /* Header */
        .header {
            background-color: #000000; /* đen */
            color: #f5e6a1; /* vàng ánh kim */
            padding: 20px;
            text-align: center;
        }
        .header h1 {
            margin: 0;
            font-size: 36px;
            text-shadow: none; /* bỏ shadow để không lòe mắt */
        }

        /* Hero Section */
        .hero {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            padding: 50px 20px;
            background-image: url('https://images.unsplash.com/photo-1555992336-c6b9b8b987b7?auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
            color: #f5e6a1;
            text-shadow: 1px 1px 2px #000; /* giảm shadow */
        }
        .hero h2 {
            font-size: 48px;
            margin-bottom: 20px;
        }
        .hero p {
            font-size: 20px;
            margin-bottom: 30px;
        }

        /* Buttons */
        .hero .buttons a {
            text-decoration: none;
            padding: 15px 30px;
            margin: 0 10px;
            font-size: 18px;
            color: #000; /* chữ đen */
            background-color: #f5e6a1; 
            transition: 0.3s;
        }
        .hero .buttons a:hover {
            background-color: #d4af37; 
            color: #000;
        }

        /* Gallery */
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            padding: 40px 20px;
            max-width: 1200px;
            margin: auto;
        }
        .gallery img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            transition: 0.3s;
            border: 2px solid #f5e6a1; /* viền vàng ánh kim */
        }
        .gallery img:hover {
            transform: scale(1.05);
            border-color: #d4af37; /* vàng đậm khi hover */
        }

        /* Footer */
        .footer {
            background-color: #000;
            color: #f5e6a1;
            text-align: center;
            padding: 20px;
        }

    </style>
</head>
<body>

    <div class="header">
        <h1>Welcome to My Restaurant</h1>
    </div>

    <div class="hero">
        <h2>Delicious Food, Memorable Experience</h2>
        <p>Book your table or manage the restaurant easily</p>
        <div class="buttons">
            <a href="StaffLoginView.jsp">Login as Staff</a>
            <a href="CustomerLoginView.jsp">Login as Customer</a>
        </div>
    </div>

    <div class="gallery">
        <img src="https://media.claytonhotels.com/image/upload/f_auto,c_auto,w_3840,q_auto/v1710853442/MigratedClaytonAssets/clayton-hotel-glasgow/restaurant-dinner.jpg" alt="Dish 1">
        <img src="https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/33/10/3e/manila-bay-kitchen-is.jpg?w=1200&h=900&s=1" alt="Dish 2">
        <img src="https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/10/9f/ba/flavors-restaurant.jpg?w=1200&h=-1&s=1" alt="Dish 3">
        <img src="https://1.bp.blogspot.com/-Zc184RomM4c/WWMBqEdU8QI/AAAAAAAAdpM/GrmlSp2LiwAj8dZT0ulvcyUvmqjY8UnzwCLcBGAs/s640/flavors%2Bholiday%2Binn%2Bmakati%2B021%2Bamerican%2Bfood%2Bfestival%2Bburger%2Bbar.jpg" alt="Dish 4">
    </div>

    <div class="footer">
        &copy; 2025 My Restaurant. All rights reserved.
    </div>

</body>
</html>
