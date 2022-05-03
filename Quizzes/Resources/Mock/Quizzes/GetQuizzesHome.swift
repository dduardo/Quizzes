//
//  GetQuizzesHome.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation

var getQuizzesHome: Data = """
{
    "quiz_list": [
                    {
                        "id_quiz": 0,
                        "group": "animals",
                        "image": "0000000000000",
                        "headline": "Que tipo de tartaruga é vocë?",
                        "description": "Descubra mais rápido que o coelho!!!"
                    },
                    {
                        "id_quiz": 1,
                        "group": "animals",
                        "image": "0000000000000",
                        "headline": "Descubra qual doguinho você seria",
                        "description": "Catiorros marotos!"
                    },
                    {
                        "id_quiz": 2,
                        "group": "kitchen",
                        "image": "0000000000000",
                        "headline": "Qual panela você seria?",
                        "description": "Ostentação de verdade é um jogo de panelas antiaderente!"
                    },
                    {
                        "id_quiz": 3,
                        "group": "food",
                        "image": "0000000000000",
                        "headline": "Qual sobremesa você é?",
                        "description": "Mais doce que o próprio doce de batata doce!"
                    },
                    {
                        "id_quiz": 4,
                        "group": "food",
                        "image": "0000000000000",
                        "headline": "teste comida",
                        "description": "teste descrição da comida"
                    }
    ]
}
""".data(using: .utf8) ?? Data()
