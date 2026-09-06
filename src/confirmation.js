function requiresConfirmation(action) {
  return ["transfer", "payment", "delete", "send"].includes(action);
}

module.exports = { requiresConfirmation };
