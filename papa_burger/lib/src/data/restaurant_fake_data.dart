restaurantsJson() {
  return {
    "restaurants": [
      {
        "id": 1,
        "name": "KFC",
        "tags": [
          {
            "name": 'Fast Food',
          },
          {
            "name": 'Drinks',
          },
          {
            "name": 'Lunch',
          },
        ],
        "menu": [
          {
            "categorie": "Lunch",
            "description": "a fun menu",
            "items": [
              {
                "name": "Muffin",
                "description": "awasome!!",
                "price": 10,
              },
              {
                "name": "Chicken Breast",
                "description": "awasome!!",
                "price": 12,
              },
            ]
          },
          {
            "categorie": "Pizza",
            "description": "a fun menu",
            "items": [
              {
                "name": "Margarita",
                "description": "awasome!!",
                "price": 9,
              },
              {
                "name": "Pepperoni",
                "description": "awasome!!",
                "price": 15,
              },
              {
                "name": "Maccarela",
                "description": "awasome!!",
                "price": 15,
              },
            ]
          },
          {
            "categorie": "Drinks",
            "description": "a fun menu",
            "items": [
              {
                "name": "Cola",
                "description": "awasome!!",
                "price": 3,
              },
              {
                "name": "Sprite",
                "description": "awasome!!",
                "price": 2,
              },
              {
                "name": "Lipton",
                "description": "awasome!!",
                "price": 4,
              },
              {
                "name": "Fanta",
                "description": "awasome!!",
                "price": 4,
              },
              {
                "name": "Water",
                "description": "awasome!!",
                "price": 4,
              },
              {
                "name": "Orange juice",
                "description": "awasome!!",
                "price": 4,
              },
            ]
          },
        ],
      },
      {
        "id": 2,
        "name": "Burger King",
        "tags": [
          {
            "name": 'Fast Food',
          },
          {
            "name": 'Burgers',
          },
          {
            "name": 'Pizza',
          },
        ],
        "menu": [
          {
            "categorie": "Pizza",
            "description": "a fun menu",
            "items": [
              {
                "name": "Margarita",
                "description": "awasome!!",
                "price": 9,
              },
              {
                "name": "Pepperoni",
                "description": "awasome!!",
                "price": 15,
              },
            ]
          },
          {
            "categorie": "Drinks",
            "description": "a fun menu",
            "items": [
              {
                "name": "Cola",
                "description": "awasome!!",
                "price": 3,
              },
              {
                "name": "Sprite",
                "description": "awasome!!",
                "price": 2,
              },
              {
                "name": "Lipton",
                "description": "awasome!!",
                "price": 4,
              },
            ]
          },
          {
            "categorie": "Burgers",
            "description": "a fun menu",
            "items": [
              {
                "name": "Whopper",
                "description": "awasome!!",
                "price": 15,
              },
              {
                "name": "McChicken",
                "description": "awasome!!",
                "price": 11,
              },
            ]
          }
        ],
      }
    ]
  };
}

restaurantMenuJson() {
  return {
    "menus": [
      {
        "id": 1,
        "name": "Lunch",
        "description": "a fun menu",
        "items": [
          {
            "name": "Muffin",
            "description": "awasome!!",
            "price": 10,
          },
          {
            "name": "Chicken Breast",
            "description": "awasome!!",
            "price": 12,
          },
        ]
      },
      {
        "id": 1,
        "name": "Pizza",
        "description": "a fun menu",
        "items": [
          {
            "name": "Margarita",
            "description": "awasome!!",
            "price": 9,
          },
          {
            "name": "Pepperoni",
            "description": "awasome!!",
            "price": 15,
          },
        ]
      },
      {
        "id": 1,
        "name": "Drinks",
        "description": "a fun menu",
        "items": [
          {
            "name": "Cola",
            "description": "awasome!!",
            "price": 3,
          },
          {
            "name": "Sprite",
            "description": "awasome!!",
            "price": 2,
          },
          {
            "name": "Lipton",
            "description": "awasome!!",
            "price": 4,
          },
        ]
      },
      {
        "id": 2,
        "name": "Burgers",
        "description": "a fun menu",
        "items": [
          {
            "name": "Whopper",
            "description": "awasome!!",
            "price": 15,
          },
          {
            "name": "McChicken",
            "description": "awasome!!",
            "price": 11,
          },
        ]
      }
    ],
  };
}
