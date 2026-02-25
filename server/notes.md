app.use('/api/issue', issueRoute)
// for editing the status of the issue--done by admin only
router.patch("/:id/status", authMiddleware, editIssueStatus)
frontend send the new status - by default is it pending, it sholud be  "in-progress", "resolved"