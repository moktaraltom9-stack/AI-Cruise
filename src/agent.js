const { requiresConfirmation } = require("./confirmation");

function plan(task, action = "") {
  const steps = [`Understand: ${task}`];
  if (requiresConfirmation(action)) {
    steps.push("Ask for explicit user confirmation");
  }
  steps.push("Execute the approved plan");
  return steps;
}

module.exports = { plan };
