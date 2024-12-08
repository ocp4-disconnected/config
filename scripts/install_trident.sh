#!/bin/bash

tridentctl install \
        --namespace trident \
        --image-registry 192.168.69.242:5000/sig-storage \
        --autosupport-image netapp/trident-autosupport:24.06 \
        --trident-image netapp/trident:24.06.0


tridentctl create backend \
        --namespace trident \
        -f "backend.json"