import speech_recognition as sr
import soundfile as sf
import os

import subprocess
import time

import wave
import contextlib

def speech2text(audio,lan):

    r = sr.Recognizer()

    src_filename = audio
    dest_filename = src_filename.split('.')[0]+'_conv.wav'

    if src_filename.split('.')[1] == 'wav':
        with contextlib.closing(wave.open(src_filename,'r')) as f:
            frames = f.getnframes()
            rate = f.getframerate()
            duration = frames / float(rate)
            print('Totale secondi: ',duration)
        
        audioRec = sr.AudioFile(src_filename)
    else:
        process = subprocess.run(['ffmpeg', '-i', src_filename, dest_filename])
        if process.returncode != 0:
            raise Exception("Something went wrong")
        
        with contextlib.closing(wave.open(dest_filename,'r')) as f:
            frames = f.getnframes()
            rate = f.getframerate()
            duration = frames / float(rate)
            print('Totale secondi: ',duration)
        
        audioRec = sr.AudioFile(dest_filename)

    totchunk = int(duration/200) # non arrotondo perché nell'ultimo file non metto limiti di tempo

    my_data = {}
    rec_data = {}

    with audioRec as source:
        for i in range(1,totchunk+2):
            try:
                foo = "parte"+str(i)+"_secondi_"+str((i-1)*200)+"_"+str((i)*200)
                my_data[foo] = r.record(source,duration=200)
                rec_data[foo] = r.recognize_google(my_data[foo],language = lan)
                print('Finito chunk ',foo)
                time.sleep(5)
            except:
                print("Errore nel chunk ",foo, ", persi i secondi tra ",200*(i-1),' e ',200*i)

    import json

    # Serialize data into file:
 #   json.dump( rec_data, open( "trascrizione.txt", 'w'), ensure_ascii=False )

    return(rec_data)
