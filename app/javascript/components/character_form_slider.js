const initializeCharacterPoints = () => {
  const attackSlider = document.getElementById("attack_points_slider");
  const healthSlider = document.getElementById("health_slider");
  const precisionSlider = document.getElementById("precision_slider");

  const attackValue = document.getElementById("attack_points_value");
  const healthValue = document.getElementById("health_value");
  const precisionValue = document.getElementById("precision_value");

  const MAX_POINTS = 200;

  if (!attackSlider || !healthSlider || !precisionSlider) return;

  const updateSliders = () => {
    const total = parseInt(attackSlider.value, 10) + parseInt(healthSlider.value, 10) + parseInt(precisionSlider.value, 10);

    if (total > MAX_POINTS) {
      const overflow = total - MAX_POINTS;

      if (attackSlider === document.activeElement) {
        healthSlider.value = Math.max(0, healthSlider.value - overflow);
        precisionSlider.value = Math.max(0, precisionSlider.value - overflow);
      } else if (healthSlider === document.activeElement) {
        attackSlider.value = Math.max(0, attackSlider.value - overflow);
        precisionSlider.value = Math.max(0, precisionSlider.value - overflow);
      } else if (precisionSlider === document.activeElement) {
        attackSlider.value = Math.max(0, attackSlider.value - overflow);
        healthSlider.value = Math.max(0, healthSlider.value - overflow);
      }
    }

    // Update visible values
    attackValue.textContent = attackSlider.value;
    healthValue.textContent = healthSlider.value;
    precisionValue.textContent = precisionSlider.value;
  };

  attackSlider.addEventListener("input", updateSliders);
  healthSlider.addEventListener("input", updateSliders);
  precisionSlider.addEventListener("input", updateSliders);
};

export default initializeCharacterPoints;