function plan(task) {
  return [`Understand: ${task}`, "Ask for confirmation before sensitive actions", "Execute the approved plan"];
}

module.exports = { plan };
