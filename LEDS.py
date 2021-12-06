#!/usr/bin/env python
import PySimpleGUI as sg
from random import randint
import subprocess
import threading
import time

from PySimpleGUI.PySimpleGUI import Window

subprocess.run(["rm","command_history.txt"])

def Battleship():
    ROWS = 10
    OPTIONS = ["ON", "Default State", "Next Mode", "Prev mode", "Next Color", "Prev Color", "Brightness Up", "Brightness Down"
                , "Color 1", "Color 2", "Color 3", "Color 4", "Color 5", "Color 6", "Color 7", "Color 8" ]
    PARAMETERS= ["OP_CODE", "Mode", "Color Set", "Brightness"]

    # Start building layout with the top 2 rows that contain Text elements
    layout =   [[sg.Text('LED Strips', font='Default 25')],
               [sg.Text(size=(15,1), key='-MESSAGE-', font='Default 20')]]
    # Add the board, a grid a buttons

    for i in range(4):
        layout += [[sg.Text(PARAMETERS[i]+" off", key=PARAMETERS[i])]]    
    

    for i in range(0,16,4):
        layout += [ 
            [sg.Button(OPTIONS[i], size=(12, 3), pad=(5,1), key=(OPTIONS[i]))] +
           [sg.Button(OPTIONS[i+1], size=(12, 3), pad=(5,1), key=(OPTIONS[i+1]))] +
           [sg.Button(OPTIONS[i+2], size=(12, 3), pad=(5,1), key=(OPTIONS[i+2]))] +
           [sg.Button(OPTIONS[i+3], size=(12, 3), pad=(5,1), key=(OPTIONS[i+3]))] 
        ]

    layout += [[sg.Button(size=(10, 5), pad=(10,10), border_width=1, key=("LED"+str(r))) for r in range(ROWS)]]

    # Add the exit button as the last row
    layout +=  [[sg.Button('Exit', button_color=('white', 'red'))]]

    window = sg.Window('Battleship', layout)


    colors = list([["#000000" for i in range(10)] for j in range(10)])
    thread = threading.Thread(target=switchcolor, args=(colors, window, ))
    thread.daemon = True
    thread.start()
    while True:         # The Event Loop
        event, values = window.read()
        print(event, values)
        if event in (sg.WIN_CLOSED, 'Exit'):
            break
        for i in range(16):
            if OPTIONS[i] == event:
                print("Command is " + str(i))
                op_code = i
                compileAndRun(op_code)
                para = parseOutput(colors)
                changePara(para, window, PARAMETERS)
                break;        
    window.close()

def changePara(para, window, PARAMETERS):
    for i in range(4):
        window[PARAMETERS[i]].update(value=PARAMETERS[i]+": "+para[i])
    
def compileAndRun(op_code):
    print("command="+str(op_code))
    subprocess.run(['iverilog', 'Space Odyssey_Interactive.v', '-o', 'pt4',"-PTestbench.command="+str(op_code)])
    subprocess.run(["./pt4"])

def parseOutput(colors):
    parameters = None
    with open("LED_COLORS.txt") as file:
        parameters = file.readline().rstrip().split(" ")
        
        while("" in parameters):
            parameters.remove("")
        for i in range(10):
            line = file.readline()
            for j in range(10):
                line = file.readline()
                colors[i][j] = "#"+line.rstrip();
    return parameters


def switchcolor(colors, window):
    while True:
        for i in range(10):
            time.sleep(1)
            for j in range(10):
                window["LED"+str(j)].update(button_color = colors[i][j])
    

Battleship()
