// app/javascript/components/character_form_slider.js

const initializeCharacterFormSliders = () => {
  const attackSlider = document.getElementById("attack_points_slider");
  const healthSlider = document.getElementById("health_slider");
  const attackValue = document.getElementById("attack_points_value");
  const healthValue = document.getElementById("health_value");
	console.log(attackSlider);

  if (!attackSlider || !healthSlider) return; // Exit if sliders are not on the page

  const MAX_POINTS = 120;

  // Function to update slider values
  const updateSliders = (changedSlider, otherSlider, changedValue, otherValue) => {
    const remainingPoints = MAX_POINTS - parseInt(changedSlider.value, 10);
    otherSlider.value = remainingPoints;
    changedValue.textContent = changedSlider.value;
    otherValue.textContent = remainingPoints;
  };

  // Event listeners for the sliders
  attackSlider.addEventListener("input", () => {
    updateSliders(attackSlider, healthSlider, attackValue, healthValue);
  });

  healthSlider.addEventListener("input", () => {
    updateSliders(healthSlider, attackSlider, healthValue, attackValue);
  });
};

export default initializeCharacterFormSliders;
