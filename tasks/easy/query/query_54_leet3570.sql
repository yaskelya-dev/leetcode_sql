SELECT
    l.book_id,
    MIN(title) AS title,
    MIN(author) AS author,
    MIN(genre) AS genre,
    MIN(publication_year) AS publication_year,
    MIN(total_copies) AS current_borrowers
FROM library_books AS l
LEFT JOIN borrowing_records AS b
ON l.book_id = b.book_id
WHERE b.return_date IS NULL
GROUP BY l.book_id
HAVING MIN(l.total_copies) = COUNT(b.book_id)
ORDER BY current_borrowers DESC, title
