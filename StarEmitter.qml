import QtQuick.Particles 2.0


ParticleSystem {
    id: sys

    function pulse(ms){
        emitter.pulse(ms)
    }

    ImageParticle {
        source: "/img/star.png"
        system: sys
        colorVariation: 1
    }

    Emitter {
        id: emitter
        system: sys

//        x: 0 //3*(parent.parent.width/4)
        width: 1000
        height: 1000
        emitRate: 500
        lifeSpan: 2000
        lifeSpanVariation: 500
        size: 10
        endSize: 20
        velocity: AngleDirection {
            angle: 90; angleVariation: 360;
            magnitude: 100
        }
        acceleration: AngleDirection {
            angle: 90; angleVariation: 360;
            magnitude: 200
        }
        enabled: false
    }
}

