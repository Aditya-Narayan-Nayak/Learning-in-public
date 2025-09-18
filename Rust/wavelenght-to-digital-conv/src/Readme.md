## Analog signal to Digital converter (ADC) for SAR satellite data in Rust.


```
The Big Idea 💡
Imagine a SAR satellite sends out a pulse. It hits the Earth and bounces back. The properties of the returning wave tell us about the surface. We'll pretend our sensor just measures the wavelength.
```

- A short wavelength might mean it hit something dense and reflective, so we'll assign it a high digital value (like a bright pixel).

- A long wavelength might mean it hit something that absorbed energy (like water), so we'll assign it a low digital value (like a dark pixel).

This is our "analog-to-digital converter"! 🛰️ ➡️ 💻