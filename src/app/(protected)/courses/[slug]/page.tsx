import { redirect } from "next/navigation";

interface CoursePageProps {
  params: Promise<{ slug: string }>;
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}

/**
 * Course page - redirects to the learn page
 * This handles Stripe checkout success redirects by preserving query params
 */
export default async function CoursePage({ params, searchParams }: CoursePageProps) {
  const { slug } = await params;
  const resolvedSearchParams = await searchParams;
  
  // Build query string from search params
  const queryParts: string[] = [];
  for (const [key, value] of Object.entries(resolvedSearchParams)) {
    if (value !== undefined) {
      if (Array.isArray(value)) {
        value.forEach(v => queryParts.push(`${encodeURIComponent(key)}=${encodeURIComponent(v)}`));
      } else {
        queryParts.push(`${encodeURIComponent(key)}=${encodeURIComponent(value)}`);
      }
    }
  }
  
  const queryString = queryParts.length > 0 ? `?${queryParts.join("&")}` : "";
  
  // Redirect to learn page with preserved query params
  redirect(`/courses/${slug}/learn${queryString}`);
}


