const initializeSelectFightersForm = () => {
  console.log("Select Fighters Form Initialized");
    console.log("Select Fighters Form Initialized");
    const fightersInput = document.getElementById("fighters-input");
    const startBattleBtn = document.getElementById("start-battle-btn");

    let selectedFighters = [];

    const updateFightersInput = () => {
      fightersInput.value = JSON.stringify(selectedFighters);
      startBattleBtn.disabled = selectedFighters.length < 2;
    };

    document.querySelectorAll(".character-card").forEach((card) => {
      const characterId = parseInt(card.dataset.characterId, 10);
      const characterSelectBtn = card.querySelector(".character-select");
      const weaponsContainer = card.querySelector(".weapons-container");
      const weaponButtons = weaponsContainer.querySelectorAll(".weapon-btn");

      // Handle Character Selection
      characterSelectBtn.addEventListener("click", () => {
        console.log("Character selected", characterId);
        const isSelected = selectedFighters.some((fighter) => fighter.character_id === characterId);

        if (isSelected) {
          // Deselect Character
          selectedFighters = selectedFighters.filter((fighter) => fighter.character_id !== characterId);
          card.classList.remove("border-success");
          weaponButtons.forEach((btn) => {
            btn.classList.remove("btn-success");
            btn.classList.add("btn-outline-secondary");
          });
          weaponsContainer.classList.add("d-none");
        } else {
          // Select Character
          selectedFighters.push({ character_id: characterId, weapon_ids: [] });
          card.classList.add("border-success");
          weaponsContainer.classList.remove("d-none");
        }

        updateFightersInput();
      });

      // Handle Weapon Selection
      weaponButtons.forEach((btn) => {
        const weaponId = parseInt(btn.dataset.weaponId, 10);

        btn.addEventListener("click", () => {
          const fighter = selectedFighters.find((fighter) => fighter.character_id === characterId);

          if (fighter) {
            const isSelected = fighter.weapon_ids.includes(weaponId);

            if (isSelected) {
              // Deselect Weapon
              fighter.weapon_ids = fighter.weapon_ids.filter((id) => id !== weaponId);
              btn.classList.remove("btn-success");
              btn.classList.add("btn-outline-secondary");
            } else {
              // Select Weapon
              fighter.weapon_ids.push(weaponId);
              btn.classList.add("btn-success");
              btn.classList.remove("btn-outline-secondary");
            }

            updateFightersInput();
          }
        });
      });

      weaponsContainer.classList.add("d-none");
    });



};

export default initializeSelectFightersForm;
