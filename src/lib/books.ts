import fs from 'node:fs/promises';
import path from 'node:path';
import { XmlParser } from 'xslt-processor';

export type Book = {
    isbn: string;
    title: string;
    author: string;
    category: string;
    pages: string;
    publisher: string;
    coverType: string;
    price: number;
    coverUrl: string;
};

const xmlPath = path.join(process.cwd(), 'src/data/libreria.xml');

const getText = (node: any, tagName: string) => {
    const match = node?.getElementsByTagName?.(tagName)?.[0];
    return match?.firstChild?.nodeValue?.toString().trim() ?? '';
};

const getAttribute = (node: any, attributeName: string) => {
    const value = node?.getAttributeValue?.(attributeName);
    return value?.toString().trim() ?? '';
};

export async function getAllBooks() {
    const xmlRaw = await fs.readFile(xmlPath, 'utf-8');
    const xmlDoc = new XmlParser().xmlParse(xmlRaw);
    const bookNodes = xmlDoc.getElementsByTagName('libro');

    return bookNodes.map((node: any) => {
        const isbn = getText(node, 'ISBN');

        return {
            isbn,
            title: getText(node, 'titulo'),
            author: getText(node, 'autor'),
            category: getAttribute(node, 'categoria'),
            pages: getText(node, 'paginas'),
            publisher: getText(node, 'editorial'),
            coverType: getAttribute(node.getElementsByTagName('tapa')?.[0], 'tipo'),
            price: Number.parseFloat(getText(node, 'precio')) || 0,
            coverUrl: `https://covers.openlibrary.org/b/isbn/${isbn}-L.jpg`,
        } satisfies Book;
    });
}

export async function getBookByIsbn(isbn: string) {
    const books = await getAllBooks();
    return books.find((book) => book.isbn === isbn) ?? null;
}
