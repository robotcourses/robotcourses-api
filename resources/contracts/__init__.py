from robot.api.deco import keyword

class contracts:

    def __init__(self):
        pass

    @keyword('Contract Post Login')
    def post_login(self, login_email, login_password):

        return {
            "email": login_email,
            "password": login_password
        }
    
    @keyword('Contract Post Carrinhos')
    def post_carrinhos(self, id_produto: list, quantidade: list):

        return {
            "produtos": [
                {
                    "idProduto": product,
                    "quantidade": quantity
                } for product, quantity in zip (id_produto, quantidade)
            ]
        }
    
    @keyword('Contract Post Usuarios')
    def post_usuarios(self, user_name, user_email, user_password, user_administrador):
        
        return {
            "nome": user_name,
            "email": user_email,
            "password": user_password,
            "administrador": user_administrador
        }