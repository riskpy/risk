
import Link from "next/link";
import { Home } from "lucide-react";

export function Sidebar(){
  return(
    <aside className='w-64 bg-elevated border-r border-white/10 hidden md:flex flex-col'>
      <div className='h-16 flex items-center gap-3 px-4 border-b border-white/10'>
        <div className='h-10 w-10 rounded-xl bg-brand-primary flex items-center justify-center text-white font-bold text-xl'>R</div>
        <span className='text-lg font-semibold'>RISK</span>
      </div>

      <nav className='flex-1 p-4 space-y-2 text-sm'>
        <Link href='/' className='flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-white/10 transition-colors'>
          <Home size={18}/> Dashboard
        </Link>
      </nav>
    </aside>
  );
}
