const { requiresConfirmation, confirmAction } = require("./confirmation");

function plan(task, action = "") {
  const steps = [`Understand: ${task}`];
  if (requiresConfirmation(action)) {
    steps.push("Ask for explicit user confirmation");
  }
  steps.push("Execute only after approval");
  return steps;
}

module.exports = { plan, confirmAction };
