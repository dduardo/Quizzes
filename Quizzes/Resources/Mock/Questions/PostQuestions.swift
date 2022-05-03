//
//  PostQuestions.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 02/05/22.
//

import Foundation


var postQuestions: Data = """
{
    "description": {
        "id_quiz": 0,
        "group": "animals",
        "image": "0000000000000",
        "headline": "Que tipo de tartaruga é vocë?",
        "description": "Descubra mais rápido que o coelho!!!"
    },
    "questions": [
        {
            "question": "Qual seu personagem favorito?",
            "answers": [
                {
                    "image": "0000000",
                    "option": "Harry Potter",
                    "value": 10
                },
                {
                    "image": "0000000",
                    "option": "Tonny Stark",
                    "value": 20
                },
                {
                    "image": "0000000",
                    "option": "Hagar o horréível",
                    "value": 30
                },
                {
                    "image": "0000000",
                    "option": "Picachu",
                    "value": 40
                },
            ]
        },
        {
            "question": "Qual seu personagem favorito2?",
            "answers": [
                {
                    "image": "0000000",
                    "option": "Harry Potter",
                    "value": 10
                },
                {
                    "image": "0000000",
                    "option": "Tonny Stark",
                    "value": 20
                },
                {
                    "image": "0000000",
                    "option": "Hagar o horréível",
                    "value": 30
                },
                {
                    "image": "0000000",
                    "option": "Picachu",
                    "value": 40
                },
            ]
        },
        {
            "question": "Qual seu personagem favorito3?",
            "answers": [
                {
                    "image": "0000000",
                    "option": "Harry Potter",
                    "value": 10
                },
                {
                    "image": "0000000",
                    "option": "Tonny Stark",
                    "value": 20
                },
                {
                    "image": "0000000",
                    "option": "Hagar o horréível",
                    "value": 30
                },
                {
                    "image": "0000000",
                    "option": "Picachu",
                    "value": 40
                },
            ]
        },
    ]
}
""".data(using: .utf8) ?? Data()
